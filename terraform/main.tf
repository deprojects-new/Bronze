terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-east-2"  # Change this to your preferred AWS region
}

module "s3_log_storage" {
  source      = "./modules/s3"
  bucket_name = "bronze-logs"
  environment = var.environment
  tags = {
    Project = "Bronze"
    Owner   = "Team"
    Env     = var.environment
    Purpose = "Log Storage"
  }
}

module "iam_users" {
  source      = "./modules/iam"
  environment = var.environment
  region      = "us-east-2"
}