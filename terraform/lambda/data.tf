data "aws_ssm_parameter" "version" {
  name = "/lambda/lambdatest/version"
}
