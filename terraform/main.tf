resource "aws_s3_bucket" "jmoit-static-website" {
  bucket = var.bucket_name

  tags = {
    Name        = "jmoit-static-website"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "jmoit-static-website" {
  bucket = aws_s3_bucket.jmoit-static-website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "jmoit-static-website" {
  bucket = aws_s3_bucket.jmoit-static-website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.jmoit-static-website.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.jmoit-static-website]
}

resource "aws_s3_bucket_public_access_block" "jmoit-static-website" {
  bucket = aws_s3_bucket.jmoit-static-website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}