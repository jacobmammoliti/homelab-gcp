module "vault_service_account" {
  source = "git@github.com:GoogleCloudPlatform/cloud-foundation-fabric.git//modules/iam-service-account?ref=v18.0.0"

  project_id   = var.project_id
  name         = "vault-sa"
  generate_key = false
}