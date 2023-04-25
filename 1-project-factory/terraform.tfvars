projects = [
  {
    billing_account = "017A11-41C11E-BB4416"
    name            = "security-core"
    prefix          = "prod"
    parent          = "840883279074"
    services = [
      "cloudkms.googleapis.com",
    ]
    iam                  = {}
    iam_additive_members = {}
    vpc_host_project     = "proj-mission-control-80492"
  },
  {
    billing_account = "017A11-41C11E-BB4416"
    name            = "power-rankings"
    prefix          = "prod"
    parent          = "840883279074"
    services = [
      "cloudfunctions.googleapis.com",
      "cloudbuild.googleapis.com",
      "cloudscheduler.googleapis.com",
      "drive.googleapis.com",
      "sheets.googleapis.com",
      "eventarc.googleapis.com",
      "run.googleapis.com",
      "artifactregistry.googleapis.com",
      "bigquery.googleapis.com",
    ]
    iam                  = {}
    iam_additive_members = {}
    vpc_host_project     = "proj-mission-control-80492"
  },
  {
    billing_account = "017A11-41C11E-BB4416"
    name            = "nexus"
    prefix          = "prod"
    parent          = "840883279074"
    services = [
      "container.googleapis.com",
      "stackdriver.googleapis.com",
    ]
    iam                  = {}
    iam_additive_members = {}
    vpc_host_project     = "proj-mission-control-80492"
    service_identity_iam = {
      "roles/container.hostServiceAgentUser" = ["container-engine"]
      "roles/compute.networkUser"            = ["container-engine"]
    }
  },
]