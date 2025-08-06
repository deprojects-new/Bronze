resource "aws_s3_bucket" "dummy_test1" {
  bucket = "${var.bucket_name}-${var.environment}-dummy-test"
  tags = var.tags
}