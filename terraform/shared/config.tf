terraform {
  backend "s3" {
    key    = "lambdatest_shared"
    bucket = "vidimensional-terraform"
    region = "eu-west-3"
  }
}

provider "aws" {
  region = "eu-west-3"
}
