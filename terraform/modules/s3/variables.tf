variable "bucket_name" {
  description = "Base name for the bucket"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev/staging/prod)"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the bucket"
  type        = map(string)
}
