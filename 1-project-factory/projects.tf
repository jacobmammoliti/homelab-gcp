resource "random_integer" "project_suffix" {
  min = 1
  max = 99999
}

module "projects" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/project?ref=v21.0.0"

  for_each = { for project in var.projects : format("%s-%s", project.prefix, project.name) => project }

  billing_account = each.value.billing_account
  prefix          = "proj"
  name            = format("%s-%s", each.value.name, random_integer.project_suffix.id)
  parent          = format("folders/%s", each.value.parent)
  services        = each.value.services
  iam             = each.value.iam

  shared_vpc_service_config = {
    attach               = true
    host_project         = each.value.vpc_host_project
    service_identity_iam = each.value.service_identity_iam
  }
}