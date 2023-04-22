variable "project_id" {
  type        = string
  description = "(required) ID of project to hold infrastructure."
}

variable "region" {
  type        = string
  description = "(optional) Default GCP region to deploy to."
  default     = "us-east1"
}
