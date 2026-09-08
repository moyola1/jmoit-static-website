resource "aws_s3_bucket" "jmoit-static-website" {
  bucket = var.bucket_name
  #force_destroy = true
  tags = {
    Name        = "jmoit-static-website"
    Environment = "Dev"
  }
}

# resource "aws_s3_bucket_website_configuration" "jmoit-static-website" {
#   bucket = aws_s3_bucket.jmoit-static-website.id

#   index_document {
#     suffix = "index.html"
#   }

#   error_document {
#     key = "error.html"
#   }
# }
resource "aws_s3_bucket_public_access_block" "jmoit-static-website" {
  bucket = aws_s3_bucket.jmoit-static-website.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
# resource "aws_s3_bucket_policy" "jmoit-static-website" {
#   bucket = aws_s3_bucket.jmoit-static-website.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = "s3:GetObject"
#         Resource  = "${aws_s3_bucket.jmoit-static-website.arn}/*"
#       }
#     ]
#   })

#   depends_on = [aws_s3_bucket_public_access_block.jmoit-static-website]
# }

resource "aws_acm_certificate" "jmoit-static-website" {
  domain_name       = "jmoitsvrs.link"
  validation_method = "DNS"
  
  subject_alternative_names = [
    "www.jmoitsvrs.link"
  ]

  tags = {
    Name        = "jmoit-static-website"
    Environment = "Dev"
  }
  # Lifecycle block to ensure the certificate is created before any resources that depend on it are destroyed
  lifecycle {
    create_before_destroy = true
  }
}