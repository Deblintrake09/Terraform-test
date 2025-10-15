terraform {
  backend "s3" {
    bucket = "test-bucket-1795"
    key = "terraform/backend"
    region = var.region
  }
}