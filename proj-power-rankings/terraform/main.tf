terraform {
  backend "gcs" {
    bucket = "bkt-core-92596"
    prefix = "terraform/proj-power-rankings/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.40.0"
    }
  }
}

provider "google" {
  project = "proj-power-rankings-15683"
  region  = "us-central1"
}