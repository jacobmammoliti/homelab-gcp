module "vpc-shared" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc?ref=v18.0.0"

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
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc-firewall?ref=v18.0.0"

  project_id = module.project.project_id
  network    = module.vpc-shared.name

  custom_rules = {
    fw-allow-all-internal = {
      description          = "Allow internal traffic on the default network"
      direction            = "INGRESS"
      action               = "allow"
      sources              = []
      ranges               = ["rfc1918"] # 172.16.0.0/12, 10.0.0.0/8, 192.168.0.0/16
      targets              = []
      use_service_accounts = false
      rules = [
        { protocol = "tcp", ports = ["0-65535"] },
        { protocol = "udp", ports = ["0-65535"] },
        { protocol = "icmp", ports = [] }
      ]
      extra_attributes = {}
    }
    fw-allow-ssh-external = {
      description          = "Allow external SSH traffic on the default network"
      direction            = "INGRESS"
      action               = "allow"
      sources              = []
      ranges               = ["34.0.0.0/8", "35.0.0.0/8"] # GCP's IP block allowing SSH only on Cloud Shell
      targets              = []
      use_service_accounts = false
      rules = [
        { protocol = "tcp", ports = ["22"] }
      ]
      extra_attributes = {}
    }
    # fw-allow-http-https-external = {
    #   description          = "Allow external HTTP/HTTPS traffic on the default network"
    #   direction            = "INGRESS"
    #   action               = "allow"
    #   sources              = []
    #   ranges               = ["0.0.0.0/0"]
    #   targets              = []
    #   use_service_accounts = false
    #   rules = [
    #     { protocol = "tcp", ports = ["80"] },
    #     { protocol = "tcp", ports = ["443"] },
    #   ]
    #   extra_attributes = {}
    # }
  }
}

module "vpc-shared-cloudnat" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-cloudnat?ref=v18.0.0"

  project_id     = module.project.project_id
  region         = var.region
  name           = "cr-default"
  router_network = module.vpc-shared.name
}