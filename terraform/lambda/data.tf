data "aws_ssm_parameter" "version" {
  name = "/lambda/${var.service_name}/version"
}

data "aws_s3_object" "source_code_hash" {
  bucket = var.s3_bucket
  key    = local.hash_s3_path
}
