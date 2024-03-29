variable "projects" {
  type = list(object({
    billing_account      = string
    name                 = string
    prefix               = string
    parent               = string
    services             = list(string)
    iam                  = map(list(string))
    iam_additive_members = map(list(string))
    vpc_host_project     = string
    service_identity_iam = map(list(string))
  }))
  description = "(required) List of projects to create."
}
