variable "environment" {
  description = "The environment to deploy to"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "Bronze"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
