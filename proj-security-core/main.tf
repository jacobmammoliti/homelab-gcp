terraform {
  backend "gcs" {
    bucket = "bkt-core-92596"
    prefix = "terraform/proj-security-core/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.33.0"
    }
  }
}

provider "google" {}