resource "random_string" "name" {
  length  = 4
  special = false
  upper   = false
}

data "archive_file" "dir_hash_zip" {
  type        = "zip"
  source_dir  = "${var.source_code_path}/"
  output_path = "${path.module}/dir_hash_zip"
}

resource "null_resource" "install_python_dependencies" {
  triggers = {
    requirements = "${sha1(file("${var.source_code_path}/requirements.txt"))}"
    dir_hash     = "${data.archive_file.dir_hash_zip.output_base64sha256}"
  }

  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/py_pkg.sh"

    environment = {
      source_code_path = var.source_code_path
      path_cwd         = path.cwd
      path_module      = path.module
      runtime          = var.runtime
      function_name    = var.function_name
      random_string    = random_string.name.result
    }
  }
}

data "archive_file" "lambda_zip" {
  depends_on  = [null_resource.install_python_dependencies]
  type        = "zip"
  source_dir  = "${path.cwd}/lambda_pkg_${random_string.name.result}/"
  output_path = var.output_path
}


# have to defined a lambda with and without dead_letter_config. _sigh_
resource "aws_lambda_function" "lambda" {
  count = var.dlc_target_arn != null ? 1 : 0
  filename         = var.output_path
  description      = var.description
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = var.role_arn
  function_name    = var.function_name
  handler          = var.handler_name
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size

  environment {
    variables = var.environment
  }

  dead_letter_config {
    target_arn = var.dlc_target_arn
  }
}

resource "aws_lambda_function" "lambda_nodlc" {
  count = var.dlc_target_arn == null ? 1 : 0
  filename         = var.output_path
  description      = var.description
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = var.role_arn
  function_name    = var.function_name
  handler          = var.handler_name
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size

  environment {
    variables = var.environment
  }

}
