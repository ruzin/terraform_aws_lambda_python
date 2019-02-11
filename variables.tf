variable "role_arn" {
  description = "ARN of IAM role to be attached to Lambda Function."
}

variable "description" {
  description = "Description of what your Lambda Function does."
}

variable "function_name" {
  description = "A unique name for your Lambda Function"
}

variable "handler_name" {
  description = "The function entrypoint in your code."
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime."
  default     = "128"
}

variable "runtime" {
  description = "runtime"
  default     = "python2.7"
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds. Defaults to 5 minutes"
  default     = "300"
}

variable "source_code_path" {
  description = "Path to the source file or directory containing your Lambda source code & requirements.txt if applicable"
}

variable "output_path" {
  description = "Path to the function's deployment package within local filesystem. eg: /path/to/lambda.zip"
  default     = "lambda.zip"
}

variable "environment" {
  description = "Environment configuration for the Lambda function"
  type        = "map"
  default     = {}
}
