output "arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.fn.arn
}
output "invoke_arn" {
  description = "ARN to be used for invoking Lambda Function from API Gateway"
  value       = aws_lambda_function.fn.invoke_arn
}