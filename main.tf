terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "${var.cloudwatch_log_group_prefix}/${var.function_name}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  tags              = var.tags
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "LambdaExecutionRole" {
  name               = "${var.function_name}LambdaExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  tags               = var.tags
}

data "aws_iam_policy_document" "LambdaPolicy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "${aws_cloudwatch_log_group.lambda.arn}:*"
    ]
  }
}

resource "aws_iam_role_policy" "LambdaRolePolicy" {
  role   = aws_iam_role.LambdaExecutionRole.id
  policy = data.aws_iam_policy_document.LambdaPolicy.json
}

resource "aws_iam_role_policy_attachment" "additional_policies" {
  count      = length(var.additional_execution_policy_arns)
  role       = aws_iam_role.LambdaExecutionRole.name
  policy_arn = var.additional_execution_policy_arns[count.index]
}

// zip package
data "archive_file" "lambda_package" {
  type        = "zip"
  source_dir  = var.src_dir
  output_path = "${var.output_path}/${var.function_name}.zip"
}

// lambda function
resource "aws_lambda_function" "fn" {
  filename         = data.archive_file.lambda_package.output_path
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  function_name    = var.function_name
  role             = aws_iam_role.LambdaExecutionRole.arn
  handler          = var.handler
  runtime          = var.runtime
  architectures    = var.architectures
  timeout          = var.timeout
  memory_size      = var.memory_size
  environment {
    variables = var.environment_variables
  }
  logging_config {
    log_format = "JSON"
    log_group  = aws_cloudwatch_log_group.lambda.name
  }
  layers = var.lambda_layer_arns

  dynamic "vpc_config" {
    for_each = var.vpc_config == null ? list(1) : []
    content {
      subnet_ids         = var.vpc_config.subnet_ids
      security_group_ids = var.vpc_config.security_group_ids
    }
  }
  tags = var.tags
}