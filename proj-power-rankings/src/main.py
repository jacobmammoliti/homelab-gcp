import os
import sys
import requests
import functions_framework
import gspread
import google.auth
from datetime import datetime, timedelta

def daily_scores(api_endpoint, worksheet):
    '''Retrieves the scores from all games the day before.

    Args:
        api_endpoint (string): API to request scores from.
        google_sheet_name (string): Name of Google Sheet to write scores to.
        google_work_sheet_name (string): Name of the specific worksheet to use in the Sheet.
    '''
    games_list = []

    yesterday = (datetime.today() - timedelta(days=1)).strftime("%Y-%m-%d")

    request = requests.get(api_endpoint + "?date=" + yesterday).json()

    for games in request["dates"][0]["games"]:
        home_team = games["teams"]["home"]["team"]["name"]
        away_team = games["teams"]["away"]["team"]["name"]

        home_team_score = games["teams"]["home"]["score"]
        away_team_score = games["teams"]["away"]["score"]

        games_list.append((yesterday, home_team, int(home_team_score), int(away_team_score), away_team))
    
    worksheet.append_rows(games_list)

# Triggered from a message on a Cloud Pub/Sub topic.
@functions_framework.cloud_event
def main(cloud_event):
    try:
        api_endpoint = os.environ["API_ENDPOINT"]
        google_sheet_name = os.environ["GOOGLE_SHEET_NAME"]
        google_work_sheet_name = os.environ["GOOGLE_SHEET_WORKSHEET_NAME"]
    except KeyError as error:
        sys.exit(1)
    
    credentials, project_id = google.auth.default(
        scopes=[
            'https://spreadsheets.google.com/feeds',
            'https://www.googleapis.com/auth/drive'
        ]
    )

    gc = gspread.authorize(credentials)
    spreadsheet = gc.open(google_sheet_name)
    worksheet = spreadsheet.worksheet(google_work_sheet_name)

    daily_scores(api_endpoint, worksheet)