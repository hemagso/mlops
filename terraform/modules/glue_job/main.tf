resource "aws_s3_object" "job_script" {
    bucket = var.script_bucket
    key = "${basename(var.script)}"
    source = var.script
    etag = filemd5(var.script)
}

resource "aws_glue_job" "main" {
    name = var.name
    role_arn = var.role.arn
    max_capacity = var.max_capacity

    command {
        script_location = "s3://${aws_s3_object.job_script.bucket}/${aws_s3_object.job_script.key}"
        python_version = "3"
        name = "glueetl"
    }

    default_arguments = {
        "--job-language" = "python"
    }
}