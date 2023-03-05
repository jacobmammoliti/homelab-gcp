module "vpc-shared" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc?ref=v20.0.0"

  project_id = module.project.project_id
  name       = "vpc-shared"
  subnets = [
    {
      ip_cidr_range      = "10.0.0.0/24"
      name               = "sb-blizzard"
      region             = var.region
      secondary_ip_range = {}
    }
  ]
}

module "vpc-shared-firewall" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc-firewall?ref=v20.0.0"

  project_id = module.project.project_id
  network    = module.vpc-shared.name

  ingress_rules = {
    allow-ingress-rfc1918 = {
      description = "Allow internal traffic on the default network"
      source_ranges = [
        "172.16.0.0/12", "10.0.0.0/8", "192.168.0.0/16"
      ]
      sources = []
      targets = []
    }
  }
}

module "vpc-shared-cloudnat" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-cloudnat?ref=v20.0.0"

  project_id     = module.project.project_id
  region         = var.region
  name           = "cr-default"
  router_network = module.vpc-shared.name
}