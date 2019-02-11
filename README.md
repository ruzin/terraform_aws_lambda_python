## Purpose
A module that allows you to cleanly package your python source code and dependencies into a zipped lambda function.

## Pre-requisites
- [Install virtualenv](https://sourabhbajaj.com/mac-setup/Python/virtualenv.html)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| description | Description of what your Lambda Function does. | string | n/a | yes |
| function\_name | A unique name for your Lambda Function | string | n/a | yes |
| handler\_name | The function entrypoint in your code. | string | n/a | yes |
| role\_arn | ARN of IAM role to be attached to Lambda Function. | string | n/a | yes |
| source\_code\_path | Path to the source file or directory containing your Lambda source code & requirements.txt if applicable | string | n/a | yes |
| environment | Environment configuration for the Lambda function | map | `{}` | no |
| memory\_size | Amount of memory in MB your Lambda Function can use at runtime. | string | `"128"` | no |
| output\_path | Path to the function's deployment package within local filesystem. eg: /path/to/lambda.zip | string | `"lambda.zip"` | no |
| runtime | runtime | string | `"python2.7"` | no |
| timeout | The amount of time your Lambda Function has to run in seconds. Defaults to 5 minutes | string | `"300"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | AWS arn of lambda function |
| function\_name | Name of lambda function |
