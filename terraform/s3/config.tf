terraform {
  backend "s3" {
    key    = "lamdatest_s3"
    bucket = "vidimensional-terraform"
    region = "eu-west-3"
  }
}

provider "aws" {
  region = "eu-west-3"
}
