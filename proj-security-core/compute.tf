# resource "google_compute_address" "vault_address" {
#   project      = var.project_id
#   region       = "us-east1"
#   name         = "vault-address"
#   address_type = "EXTERNAL"
#   network_tier = "PREMIUM"
# }

# data "google_compute_network" "shared_vpc" {
#   project = "proj-mission-control-80492"
#   name = var.networking.network
# }

# data "google_compute_subnetwork" "shared_subnet" {
#   project = "proj-mission-control-80492"
#   name   = var.networking.subnetwork
#   region = "us-east1"
# }

# module "vault" {
#   source = "git@github.com:GoogleCloudPlatform/cloud-foundation-fabric.git//modules/compute-vm?ref=v18.0.0"

#   project_id    = var.project_id
#   zone          = var.zone
#   name          = "vault-0"
#   description   = "HashiCorp Vault compute instance"
#   instance_type = "e2-micro"

#   network_interfaces = [
#     {
#       network    = data.google_compute_network.shared_vpc.self_link
#       subnetwork = data.google_compute_subnetwork.shared_subnet.self_link
#       nat        = true
#       addresses = {
#         internal = null
#         external = google_compute_address.vault_address.address
#       }
#     }
#   ]

#   tags = [
#     "hashicorp-vault"
#   ]

#   boot_disk = {
#     image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
#     type  = "pd-standard"
#     size  = 20
#   }

#   service_account_create = true
#   service_account_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
# }