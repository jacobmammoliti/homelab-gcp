variable "admin_group" {
  type        = string
  description = "(required) Email alias for Google admin group."
}

variable "billing_account_id" {
  type        = string
  description = "(required) Billing account ID."
}

variable "billing_admins_group" {
  type        = string
  description = "(required) Email alias for Google billing admin group."
}

variable "domain" {
  type        = string
  description = "(required) Domain of organization."
}

variable "folders" {
  type = list(object({
    name      = string
    iam       = map(list(string))
    group_iam = map(list(string))
  }))
  description = "(required) List of folders to create."
}

variable "github_organization" {
  type        = string
  description = "(required) Organization of the GitHub repository to use for Workload Identity Federation."
}

variable "github_repository" {
  type        = string
  description = "(required) Name of the GitHub repository to use for Workload Identity Federation."
}

variable "region" {
  type        = string
  description = "(optional) Region for VPC and Bucket."
  default     = "us-east1"
}
