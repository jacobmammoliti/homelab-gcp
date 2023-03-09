module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = module.project.project_id
  pool_id     = "github-pool-prod"
  provider_id = "github-provider-prod"
  sa_mapping = {
    "terraform-service-account" = {
      sa_name   = module.wif-terraform-service-account.id
      attribute = format("attribute.repository/%s/%s", var.github_organization, var.github_repository)
    },
    "artifact-registry-account" = {
      sa_name   = module.wif-artifact-registry-service-account.id
      attribute = format("attribute.repository/%s/scouter", var.github_organization)     
    }
  }
}