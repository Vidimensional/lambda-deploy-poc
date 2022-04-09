resource "aws_s3_bucket" "lambdatest" {
  bucket = "vidi-lambdacode"
}


resource "aws_s3_bucket_acl" "lambdatest" {
  bucket = aws_s3_bucket.lambdatest.id
  acl    = "private"
}
