terraform {
  backend "s3" {
    bucket       = "BUCKET NAME" # create the bucket outside of terraform and insert name here
    key          = "PATH/TO/.tfstate" # specify path to where you want state file
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}
