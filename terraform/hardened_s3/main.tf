resource "aws_s3_bucket" "example" {
  bucket = "detection-as-code-example-bucket"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_logging" "example" {
  bucket        = aws_s3_bucket.example.id
  target_bucket = aws_s3_bucket.example.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    id     = "expire-old-logs"
    status = "Enabled"

    expiration {
      days = 90
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_s3_bucket_notification" "example" {
  bucket = aws_s3_bucket.example.id
}

resource "aws_s3_bucket_replication_configuration" "example" {
  role   = "arn:aws:iam::123456789012:role/replication-role"
  bucket = aws_s3_bucket.example.id
  rule {
    id     = "replicate-all"
    status = "Enabled"
    destination {
      bucket = "arn:aws:s3:::detection-as-code-replica-bucket"
    }
  }
}