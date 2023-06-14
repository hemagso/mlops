output "bucket_name" {
    value = aws_s3_bucket.main.bucket
    description = "The name of the bucket"
}

output "read_policy" {
    value = aws_iam_policy.read_policy
    description = "The read policy for the bucket"
}

output "write_policy" {
    value = aws_iam_policy.write_policy
    description = "The write policy for the bucket"
}