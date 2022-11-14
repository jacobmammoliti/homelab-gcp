module "wif-terraform-service-account" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/iam-service-account?ref=v18.0.0"

  project_id   = module.project.project_id
  name         = "terraform-orchestrator"
  description  = "Terraform WIF service account"
  generate_key = false
  
  iam_organization_roles = {
    (data.google_organization.org.org_id) = [
      "roles/orgpolicy.policyAdmin",
      "roles/iam.organizationRoleAdmin",
      "roles/iam.serviceAccountAdmin",
      "roles/resourcemanager.organizationViewer",
      "roles/resourcemanager.folderCreator",
      "roles/resourcemanager.projectCreator",
      "roles/owner",
      "roles/billing.user",
      "roles/compute.xpnAdmin"
    ]
  }
}