resource "google_cloud_scheduler_job" "get_nhl_scores_daily_job" {
  name        = "get-nhl-scores-daily"
  description = "Trigger pubsub topic every day at 05:00 AM."
  schedule    = "0 5 * * *"
  time_zone   = "America/Toronto"

  pubsub_target {
    topic_name = google_pubsub_topic.get_nhl_scores.id
    data       = base64encode("fetch_scores")
  }
}