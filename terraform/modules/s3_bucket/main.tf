resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
}

data "aws_iam_policy_document" "read_policy_document" {
  statement {
    actions  = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.main.arn}/*"]
  }
}

resource "aws_iam_policy" "read_policy" {
  name        = "${var.bucket_name}_read_policy"
  description = "Allow reading options from bucket ${var.bucket_name}"
  policy      = data.aws_iam_policy_document.read_policy_document.json
}

data "aws_iam_policy_document" "write_policy_document" {
    statement {
        actions = ["s3:PutObject"]
        resources = ["${aws_s3_bucket.main.arn}"]
    }
}

resource "aws_iam_policy" "write_policy" {
  name        = "${var.bucket_name}_write_policy"
  description = "Allow writing options to bucket ${var.bucket_name}"
  policy      = data.aws_iam_policy_document.write_policy_document.json
}