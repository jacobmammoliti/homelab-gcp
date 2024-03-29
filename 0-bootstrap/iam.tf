module "wif-terraform-service-account" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/iam-service-account?ref=v21.0.0"

  project_id   = module.project.project_id
  name         = "terraform-orchestrator"
  description  = "Terraform WIF service account"
  generate_key = false

  iam_organization_roles = {
    (data.google_organization.org.org_id) = [
      "roles/orgpolicy.policyAdmin",
      "roles/iam.organizationRoleAdmin",
      "roles/iam.serviceAccountAdmin",
      "roles/iam.securityAdmin",
      "roles/resourcemanager.organizationViewer",
      "roles/resourcemanager.folderCreator",
      "roles/resourcemanager.projectCreator",
      "roles/billing.user",
      "roles/compute.xpnAdmin",
      "roles/compute.networkAdmin",
      "roles/bigquery.user",
      "roles/artifactregistry.admin",
      "roles/storage.admin",
      "roles/iam.workloadIdentityPoolAdmin",
      "roles/compute.securityAdmin",
      "roles/serviceusage.serviceUsageAdmin",
    ]
  }
}

module "wif-artifact-registry-service-account" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/iam-service-account?ref=v21.0.0"

  project_id   = module.project.project_id
  name         = "artifact-registry-pusher"
  description  = "Artifact Registry Pusher WIF service account"
  generate_key = false

  iam_project_roles = {
    (module.project.project_id) = [
      "roles/artifactregistry.writer",
    ]
  }
}