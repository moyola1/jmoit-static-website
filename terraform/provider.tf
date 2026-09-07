provider "aws" {
  region = "us-east-1"  # To use ACM with CloudFront
}

terraform {
  backend "s3" {
    bucket       = "my-secure-s3-bucket-593"
    region       = "us-east-1"
    key          = "terraform/dev/jmoit-static-website/terraform.tfstate"
    encrypt      = true
    use_lockfile = true // Prevents Terraform backend from being modified by another.
  }
}