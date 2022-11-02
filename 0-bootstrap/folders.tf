module "folders" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/folder?ref=v18.0.0"

  for_each = { for folder in var.folders : folder.name => folder }

  parent    = data.google_organization.org.name
  name      = each.value.name
  group_iam = each.value.group_iam
  iam       = each.value.iam
}