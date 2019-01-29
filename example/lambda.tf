module "lambda_zip" {
  source           = ""
  output_path      = "lambda_function.zip"
  description      = "example for lambda module"
  source_code_path = "${path.cwd}/source_code/"
  role_arn         = ""
  function_name    = "hello_world"
  handler_name     = "hello_world.handler"
  runtime          = "python3.6"

  environment {
    variables = {
      ENVIRONMENT = "test"
    }
  }
}

provider "aws" {
  profile = "cloudsandbox"
  region  = "eu-west-1"
}
