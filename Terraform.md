## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.LambdaExecutionRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.LambdaRolePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.additional_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.fn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [archive_file.lambda_package](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_iam_policy_document.LambdaPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_execution_policy_arns"></a> [additional\_execution\_policy\_arns](#input\_additional\_execution\_policy\_arns) | The ARNs of the additional IAM policies for the Lambda function | `list(string)` | `[]` | no |
| <a name="input_architectures"></a> [architectures](#input\_architectures) | The architectures for the Lambda function | `list(string)` | <pre>[<br>  "arm64"<br>]</pre> | no |
| <a name="input_cloudwatch_log_group_prefix"></a> [cloudwatch\_log\_group\_prefix](#input\_cloudwatch\_log\_group\_prefix) | The prefix of the CloudWatch log group for the Lambda function | `string` | n/a | yes |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | The retention in days of the CloudWatch log group for the Lambda function | `number` | `7` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | The environment variables for the Lambda function | `map(string)` | `{}` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | The name of the Lambda function | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | The handler for the Lambda function | `string` | `"index.handler"` | no |
| <a name="input_lambda_layer_arns"></a> [lambda\_layer\_arns](#input\_lambda\_layer\_arns) | The ARNs of the Lambda layers for the Lambda function | `list(string)` | `[]` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | The memory size for the Lambda function | `number` | `128` | no |
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | The output path for the Lambda function zip package | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The runtime for the Lambda function | `string` | `"nodejs20.x"` | no |
| <a name="input_src_dir"></a> [src\_dir](#input\_src\_dir) | The source directory for the Lambda function | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags for the Lambda function | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The timeout for the Lambda function | `number` | `5` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | The VPC configuration for the Lambda function | <pre>object({<br>    subnet_ids         = list(string)<br>    security_group_ids = list(string)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
