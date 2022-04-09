resource "aws_ssm_parameter" "lambdatest" {
  name  = "/lambda/lambdatest/version"
  type  = "String"
  value = "none"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
