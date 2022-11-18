resource "google_service_account" "cloud_function_service_account" {
  account_id   = "get-nhl-scores-function-sa"
  display_name = "Get NHL Scores service account"
  description  = "Service account used by the get-nhl-scores Cloud Function."
}

resource "google_cloudfunctions2_function" "get_nhl_scores" {
  name        = "get-nhl-scores"
  location    = data.google_client_config.current.region
  description = "This function retrieves the scores from NHL games on a given day and writes them to a Google Sheet."

  build_config {
    runtime     = "python310"
    entry_point = "main" # Python function to call
    source {
      storage_source {
        bucket = module.bucket.name
        object = google_storage_bucket_object.source_code.name
      }
    }
  }

  service_config {
    max_instance_count    = 1
    available_memory      = "256M"
    timeout_seconds       = 60
    service_account_email = google_service_account.cloud_function_service_account.email
    environment_variables = {
      PR_BASE_URL   = "https://statsapi.web.nhl.com/api/v1/schedule"
      PR_BQ_DATASET = module.bigquery-dataset.dataset_id
      PR_BQ_TABLE   = keys(module.bigquery-dataset.table_ids)[0]
      PR_PROJECT_ID = data.google_client_config.current.project
    }
  }

  event_trigger {
    event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = google_pubsub_topic.get_nhl_scores.id
    retry_policy   = "RETRY_POLICY_RETRY"
    trigger_region = data.google_client_config.current.region
  }
}