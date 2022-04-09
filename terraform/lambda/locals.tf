locals {
  # FIXME if those files does not exist, Terraform execution will fail
  code_s3_path = "${var.service_name}/code.${data.aws_ssm_parameter.version.value}.zip"
  hash_s3_path = "${var.service_name}/code.${data.aws_ssm_parameter.version.value}.zip.sha256"
}
