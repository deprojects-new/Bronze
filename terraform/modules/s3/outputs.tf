output "bucket_id" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.log_storage.id
}

output "bucket_arn" {
  description = "The ARN of the bucket"
  value       = aws_s3_bucket.log_storage.arn
}

output "bucket_domain_name" {
  description = "The bucket domain name"
  value       = aws_s3_bucket.log_storage.bucket_domain_name
}

output "versioning_enabled" {
  description = "Whether versioning is enabled"
  value       = aws_s3_bucket_versioning.log_storage_versioning.versioning_configuration[0].status
}

output "lifecycle_rules" {
  description = "List of lifecycle rules"
  value = aws_s3_bucket_lifecycle_configuration.log_storage_lifecycle.rule[*].id
}
