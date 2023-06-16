module "test_lambda" {
    source = "../../modules/lambda"
    name = "test"
    handler = "lambda.handler"
    runtime = "python3.8"
    package = "../../../build/test.zip"
    memory_size = 128
    iam_policies = []
}