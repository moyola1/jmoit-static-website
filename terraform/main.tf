resource "aws_s3_bucket" "jmoit-static-website" {
  bucket = var.bucket_name

  tags = {
    Name        = "jmoit-static-website"
    Environment = "Dev"
  }
}