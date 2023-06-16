resource "aws_iam_role" "glue_job_role" {
  name               = "GlueJobRoleForTesting"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "glue.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "glue_job_policy" {
  name        = "GlueJobPolicyForTesting"
  description = "My policy that grants permissions to Glue and S3 for testing"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action   = "glue:*",
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_job_role_policy_attachment" {
  policy_arn = aws_iam_policy.glue_job_policy.arn
  role       = aws_iam_role.glue_job_role.name
}


module "glue_job" {
    source = "../../modules/glue_job"
    script_bucket = module.jobs_bucket.bucket_name
    name = "test-job"
    script = "../../../app/glue/test.py"
    role = aws_iam_role.glue_job_role
}