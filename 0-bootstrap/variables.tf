variable "billing_account_id" {
  type        = string
  description = "Billing account ID."
}

variable "domain" {
  type        = string
  description = "Domain of organization."
}

variable "folders" {
  type = list(object({
    name      = string
    iam       = map(list(string))
    group_iam = map(list(string))
  }))
  description = "List of folders to create."
}

variable "region" {
  type        = string
  description = "Region for VPC and Bucket."
  default     = "us-east1"
}

variable "github_organization" {
  type        = string
  description = "Organization of the GitHub repository to use for Workload Identity Federation."
}

variable "github_repository" {
  type        = string
  description = "Name of the GitHub repository to use for Workload Identity Federation."
}