resource "aws_s3_bucket" "builds" {
  bucket = local.bucket_name
}

module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "5.2.0"

  function_name = "${var.project_name}-process-iot-data"
  runtime       = "python3.11"
  handler       = "src.iot_data_processor_handler.lambda_handler"
  lambda_role   = aws_iam_role.iam_for_lambda.arn
  create_role   = false
  environment_variables = {
  }

  memory_size = 1028
  timeout     = 30

  create_package = false
  s3_existing_package = {
    bucket = aws_s3_bucket.builds.id
    key    = aws_s3_object.lambda_package.id
  }
}

resource "aws_s3_object" "lambda_package" {
  bucket = aws_s3_bucket.builds.id
  key    = "${filemd5(local.lambda_package)}.zip"
  source = local.lambda_package
}

module "lambda-iot-send-command" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "5.2.0"

  function_name = "${var.project_name}-send-iot-command"
  runtime       = "python3.11"
  handler       = "src.iot_send_command_handler.lambda_handler"
  lambda_role   = aws_iam_role.iam_for_lambda.arn
  create_role   = false
  environment_variables = {
  }

  memory_size = 1028
  timeout     = 30

  create_package = false
  s3_existing_package = {
    bucket = aws_s3_bucket.builds.id
    key    = aws_s3_object.lambda_package.id
  }
}
