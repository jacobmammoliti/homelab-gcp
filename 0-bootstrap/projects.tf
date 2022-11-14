resource "random_integer" "project_suffix" {
  min = 1
  max = 99999
}

module "project" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/project?ref=v18.0.0"

  billing_account = var.billing_account_id
  name            = format("mission-control-%s", random_integer.project_suffix.id)
  parent          = module.folders["common"].id
  prefix          = "proj"
  services = [
    "dns.googleapis.com",
    "artifactregistry.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "iam.googleapis.com",
    "cloudbilling.googleapis.com",
    "bigquery.googleapis.com"
  ]
  shared_vpc_host_config = {
    enabled          = true
    service_projects = []
  }
}