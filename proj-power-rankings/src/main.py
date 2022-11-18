import os
import sys
import json
import logging
import requests
import pandas as pd
import functions_framework
from datetime import datetime, timedelta
from google.cloud import bigquery
from google.api_core.exceptions import NotFound

logging.basicConfig(
    stream=sys.stdout,
    level=logging.INFO,
    format="[%(levelname)s] %(asctime)s %(message)s",
    datefmt="%m/%d/%Y %H:%M:%S",
)

def get_env() -> dict:
    logging.info("Retrieving environment variables.")
    env_vars = {}

    for key, value in os.environ.items():
        if key[:3] == "PR_":
            key = key[3:].lower()
            env_vars[key] = value
    
    return env_vars

def initialize_data_frame() -> pd.DataFrame:
    logging.info("Initializing Pandas DataFrame.")
    return pd.DataFrame()

def fetch_board_via_file(data_file: str) -> dict:
    logging.info(f"Fetching board from file {data_file}.")

    with open(data_file, encoding = "utf-8") as file:
        data = json.load(file)
    
    return data

def fetch_board_via_url(env_vars: dict) -> dict:
    try:
        base_url = env_vars["base_url"]
    except KeyError as error:
        logging.error(f"{error} not found in environment variables.")
        sys.exit(1)

    logging.info(f"Fetching board from URL.")

    yesterday = (datetime.today() - timedelta(days=1)).strftime("%Y-%m-%d")
    request = requests.get(f"{base_url}?date={yesterday}")

    if request.status_code != 200:
        logging.error(f"Did not get a 200 response back. Got {request.status_code}.")
        sys.exit(1)
    
    return request.json()

def build_data_frame(data: dict, df: pd.DataFrame) -> pd.DataFrame:
    logging.info("Building DataFrame.")

    for games in data["dates"][0]["games"]:
        new_df = pd.DataFrame([{
            "date": (datetime.today() - timedelta(days=1)).strftime("%Y-%m-%d"),
            "home_team": games["teams"]["home"]["team"]["name"],
            "home_team_score": games["teams"]["home"]["score"],
            "away_team_score": games["teams"]["away"]["score"],
            "away_team": games["teams"]["away"]["team"]["name"],
        }])

        df = pd.concat([df, new_df], ignore_index=True)

    return df

def write_to_bigquery(env_vars: dict, df: pd.DataFrame) -> None:
    try:
        bq_table = env_vars["bq_table"]
        bq_project_id = env_vars["project_id"]
        bq_dataset = env_vars["bq_dataset"]
    except KeyError as error:
        logging.error(f"{error} not found in environment variables.")
        sys.exit(1)
    
    logging.info("Writing to BigQuery.")

    client = bigquery.Client(project=bq_project_id)

    try:
        client.get_dataset(bq_dataset)
    except NotFound as error:
        logging.error(f"Dataset not found. Got: {error}.")
        sys.exit(1)

    try:
        table_ref = client.dataset(bq_dataset).table(bq_table)
        table = client.get_table(table_ref)
    except NotFound as error:
        logging.error(f"Table not found. Got: {error}.")
        sys.exit(1)
    
    try:
        errors = client.insert_rows_from_dataframe(table, df)
    except ValueError as error:
        logging.error(f"Table's schema not set. Got {error}.")
        sys.exit(1)
    
    if any(errors):
        logging.error(errors)
        sys.exit(1)
    else:
        logging.info("Successfully wrote games to Big Query.")

# Triggered from a message on a Cloud Pub/Sub topic.
# @functions_framework.cloud_event
def main(cloud_event=None):
    if len(sys.argv) > 1:
        data = fetch_board_via_file(sys.argv[1])
    else:
        env_vars = get_env()

        data = fetch_board_via_url(env_vars)
    
    df = build_data_frame(data, initialize_data_frame())

    write_to_bigquery(env_vars, df)

if __name__ == "__main__":
    main()