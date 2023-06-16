variable "name" {
  description = "The name of the function"
  type        = string
}

variable "runtime" {
  description = "The runtime of the function"
  type        = string
}

variable "handler" {
  description = "The handler of the function"
  type        = string
}

variable "package" {
  description = "The package of the function"
  type        = string
}

variable "memory_size" {
  description = "The memory size of the function"
  type        = number
}

variable "iam_policies" {
    description = "The IAM policies of the function"
    type        = list(object({ arn = string}))
}
