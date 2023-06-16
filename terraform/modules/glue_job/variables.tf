variable "script_bucket" {
  description = "Name of the S3 Bucket to store the scripts in"
  type = string
}

variable "name" {
    description = "Name of the Glue Job"
    type = string
}

variable "script" {
    description = "Path to the script to run"
    type = string
}

variable "role" {
    description = "IAM Role for the Glue Job"
    type = object({
        name = string
        arn = string
    })
}

variable "max_capacity" {
    description = "Maximum number of Glue DPUs to use when running the job"
    type = number
    default = 2
}