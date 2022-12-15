module "docker_artifact_registry" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/artifact-registry?ref=v18.0.0"

  project_id = module.project.project_id
  location   = var.region
  format     = "DOCKER"
  id         = "core"
  iam = {
    "roles/artifactregistry.admin" = [format("group:%s", var.admin_group)]
  }
}