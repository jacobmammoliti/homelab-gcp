module "org" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/organization?ref=v18.0.0"

  organization_id = data.google_organization.org.name
  group_iam = {
    (var.admin_group) = [
      "roles/resourcemanager.folderViewer",
      "roles/logging.viewer",
      "roles/resourcemanager.organizationViewer",
      "roles/orgpolicy.policyViewer",
      "roles/iam.organizationRoleViewer",
      "roles/owner",
      "roles/securitycenter.adminViewer",
      "roles/cloudsupport.viewer",
    ]
  }
  policy_boolean = {
    "constraints/compute.skipDefaultNetworkCreation" = true
  }
}