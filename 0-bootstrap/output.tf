output "bucket_name" {
  description = "GCP bucket name for Terraform state."
  value       = module.bucket.name
}