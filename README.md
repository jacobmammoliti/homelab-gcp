# :cloud: GCP Homelab

## :book: Overview
This repository contains all the Terraform used to manage my Google Cloud Platform (GCP) organization. It heavily leverages the [Cloud Foundation Fabric](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric) modules from Google Cloud.

## :open_file_folder: Directory Structure
The directory structure of this repository is shown below. For more specific details, see the README in each directory.

> **Note:** Project directories are stored in this repository for simplicity and to provide examples. Project directories can (and probably should) have a dedicated repository.

```bash
./
├── ./0-bootstrap        # bootstraps the organization
├── ./1-project-factory  # creates all projects for the organization
└── ./proj-security-core # contains all security components for the organization
```