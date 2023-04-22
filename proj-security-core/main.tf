terraform {
  required_version = ">= 1.4.5"
  
  backend "gcs" {
    bucket = "bkt-core-92596"
    prefix = "terraform/proj-security-core/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.33.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.3.2"
    }
  }
}

provider "google" {
  impersonate_service_account = "terraform-orchestrator@proj-mission-control-80492.iam.gserviceaccount.com"
}