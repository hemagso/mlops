resource "aws_iam_role" "main" {
    name = "lambda-${var.name}-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid    = ""
                Principal = {
                    Service = "lambda.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "main" {
    count = length(var.iam_policies)
    role = aws_iam_role.main.name
    policy_arn = var.iam_policies[count.index].arn
}

resource "aws_lambda_function" "main" {
  function_name = var.name
  role          = aws_iam_role.main.arn
  handler       = var.handler
  runtime       = var.runtime
  filename      = var.package
  source_code_hash = "${filebase64(var.package)}"
}