module "input_bucket" {
  source = "../../modules/s3_bucket"
  bucket_name = "002867874486-input-bucket"
}

module "output_bucket" {
  source = "../../modules/s3_bucket"
  bucket_name = "002867874486-output-bucket"
}

module "jobs_bucket" {
  source = "../../modules/s3_bucket"
  bucket_name = "002867874486-jobs-bucket"
}