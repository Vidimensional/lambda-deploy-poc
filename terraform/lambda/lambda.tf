resource "aws_lambda_function" "lambdatest" {
  function_name = var.service_name
  role          = aws_iam_role.lambdatest.arn
  runtime       = "python3.9"
  handler       = "lambda.main.handler"
  s3_bucket     = var.s3_bucket
  s3_key        = local.code_s3_path
  # We need the hash to know when the code changes.
  source_code_hash = base64encode(data.aws_s3_object.source_code_hash.body)
}
