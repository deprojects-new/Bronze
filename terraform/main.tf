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

module "s3_dummy" {
  source      = "./modules/s3"
  bucket_name = "bronze-unique-test"
  environment = var.environment
  tags = {
    Project = "BronzeGuide"
    Owner   = "AAJaisiv"
    Env     = var.environment
  }
}