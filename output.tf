output "function_name" {
  description = "Name of lambda function"
  value       = join("", concat(aws_lambda_function.lambda.*.function_name, aws_lambda_function.lambda_nodlc.*.function_name))
}

output "arn" {
  description = "AWS arn of lambda function"
  value       = join("", concat(aws_lambda_function.lambda.*.arn, aws_lambda_function.lambda_nodlc.*.arn))
}
