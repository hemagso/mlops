resource "aws_s3_object" "credit_dataset" {
  bucket = module.input_bucket.bucket_name
  key    = "credit_dataset.csv"
  source = "../../../data/UCI_Credit_Card.csv"
  etag   = filemd5("../../../data/UCI_Credit_Card.csv")
}
