output "bucket-name" {
  value = aws_s3_bucket.jmoit-static-website.bucket
}

output "certificate-arn" {
  value = aws_acm_certificate.jmoit-static-website.arn
}