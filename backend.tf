terraform {
  backend "s3" {
    bucket       = "test-cloudfront-s3-demo-bucket"
    key          = "dev/s3-cloudfront.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}