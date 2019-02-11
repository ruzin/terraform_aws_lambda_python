output "function_name" {
  description = "Name of lambda function"
  value       = "${aws_lambda_function.lambda.function_name}"
}

output "arn" {
  description = "AWS arn of lambda function"
  value       = "${aws_lambda_function.lambda.arn}"
}
