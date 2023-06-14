
terraform {
  backend "s3" {
    bucket = "002867874486-terraform"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

