module "org" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/organization?ref=v18.0.0"

  organization_id = data.google_organization.org.name
  policy_boolean = {
    "constraints/compute.skipDefaultNetworkCreation" = true
  }
}