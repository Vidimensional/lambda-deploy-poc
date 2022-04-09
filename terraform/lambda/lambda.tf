locals {
  # FIXME if those files does not exist, Terraform execution will fail
  code_s3_path = "${var.service_name}/code.${data.aws_ssm_parameter.version.value}.zip"
  hash_s3_path = "${var.service_name}/code.${data.aws_ssm_parameter.version.value}.zip.sha256"
}

data "aws_s3_object" "source_code_hash" {
  bucket = var.s3_bucket
  key    = local.hash_s3_path
}

resource "aws_lambda_function" "lambdatest" {
  function_name = "lambdatest"
  role          = aws_iam_role.lambdatest.arn
  runtime       = "python3.9"
  handler       = "lambda.main.handler"
  s3_bucket     = var.s3_bucket
  s3_key        = local.code_s3_path
  # We need the hash to know when the code changes.
  source_code_hash = base64encode(data.aws_s3_object.source_code_hash.body)
}
