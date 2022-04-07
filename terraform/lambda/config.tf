terraform {
  backend "s3" {
    key    = "lamdatest_lambda"
    bucket = "vidimensional-terraform"
    region = "eu-west-3"
  }
}

provider "aws" {
  region = "eu-west-3"
}
