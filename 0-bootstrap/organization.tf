module "org" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/organization?ref=v21.0.0"

  organization_id = data.google_organization.org.name
  group_iam = {
    (var.admin_group) = [
      "roles/resourcemanager.folderViewer",
      "roles/logging.viewer",
      "roles/resourcemanager.organizationViewer",
      "roles/orgpolicy.policyViewer",
      "roles/iam.organizationRoleAdmin",
      "roles/securitycenter.adminViewer",
      "roles/cloudsupport.viewer",
      "roles/compute.networkViewer",
      "roles/owner",
      "roles/iam.serviceAccountTokenCreator",
    ]

    (var.billing_admins_group) = [
      "roles/billing.admin",
      "roles/billing.creator",
    ]
  }
  org_policies = {
    "constraints/compute.skipDefaultNetworkCreation" = {
      rules = [{ enforce = true }]
    }
  }
}