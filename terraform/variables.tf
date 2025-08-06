variable "environment" {
  description = "The environment to deploy to"
  type        = string
}

variable "lambda_timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 300
}

variable "lambda_memory_size" {
  description = "Lambda function memory size in MB"
  type        = number
  default     = 128
}

variable "s3_bucket_name" {
  description = "S3 bucket name for log storage"
  type        = string
}

variable "glue_job_timeout" {
  description = "Glue job timeout in minutes"
  type        = number
  default     = 60
}

variable "enable_logging" {
  description = "Enable detailed logging"
  type        = bool
  default     = true
}
