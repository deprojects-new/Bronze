# S3 Bucket for Log Storage
resource "aws_s3_bucket" "log_storage" {
  bucket = "${var.bucket_name}-${var.environment}"
  
  tags = merge(var.tags, {
    Purpose = "Log Storage"
  })
}

# Enable versioning
resource "aws_s3_bucket_versioning" "log_storage_versioning" {
  bucket = aws_s3_bucket.log_storage.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# Basic lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "log_storage_lifecycle" {
  bucket = aws_s3_bucket.log_storage.id

  rule {
    id     = "basic_lifecycle_rule"
    status = "Enabled"

    # Add filter to fix the warning
    filter {
      prefix = ""
    }

    # Current version lifecycle - expire after 15 days
    expiration {
      days = 15
    }

    # Non-current version lifecycle - expire after 15 days
    noncurrent_version_expiration {
      noncurrent_days = 15
    }
  }
}
