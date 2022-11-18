locals {
  nhl_scores_schema = jsonencode([
    { name = "date", type = "STRING" },
    { name = "home_team_name", type = "STRING" },
    { name = "home_team_score", type = "INT64" },
    { name = "away_team_score", type = "INT64" },
    { name = "away_team_name", type = "STRING" },
  ])
}

module "bigquery-dataset" {
  source     = "git@github.com:GoogleCloudPlatform/cloud-foundation-fabric.git//modules/bigquery-dataset?ref=v18.0.0"
  project_id = data.google_client_config.current.project
  id         = "nhl_scores_2022_2023"
  location   = "US"
  iam = {
    "roles/bigquery.dataOwner" = [format("serviceAccount:%s", google_service_account.cloud_function_service_account.email)]
  }

  tables = {
    nhl_scores = {
      friendly_name       = "scores"
      labels              = {}
      options             = null
      partitioning        = null
      schema              = local.nhl_scores_schema
      deletion_protection = true
    }
  }
}