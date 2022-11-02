resource "random_integer" "bucket_suffix" {
  min = 1
  max = 99999
}

module "bucket" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gcs?ref=v18.0.0"

  project_id    = module.project.project_id
  prefix        = "bkt"
  name          = format("core-%s", random_integer.bucket_suffix.id)
  location      = upper(var.region)
  storage_class = "STANDARD"
}