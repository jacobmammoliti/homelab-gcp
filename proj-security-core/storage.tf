resource "random_integer" "bucket_suffix" {
  min = 1
  max = 99999
}

module "bucket" {
  source = "git@github.com:GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gcs?ref=v18.0.0"

  project_id    = var.project_id
  prefix        = "bkt"
  name          = format("vault-storage-%s", random_integer.bucket_suffix.id)
  location      = upper(var.region)
  storage_class = "STANDARD"
  iam = {
    "roles/storage.objectAdmin" = [module.vault_service_account.iam_email]
  }
}