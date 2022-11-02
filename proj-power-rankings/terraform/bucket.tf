resource "random_integer" "bucket_suffix" {
  min = 1
  max = 99999
}

module "bucket" {
  source = "git@github.com:GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gcs?ref=v18.0.0"

  project_id    = data.google_client_config.current.project
  prefix        = "bkt"
  name          = format("nhl-power-rankings-%s", random_integer.bucket_suffix.id)
  location      = data.google_client_config.current.region
  storage_class = "STANDARD"
}

resource "google_storage_bucket_object" "source_code" {
  name   = "code/src.zip"
  bucket = module.bucket.name
  source = "../src.zip"
}