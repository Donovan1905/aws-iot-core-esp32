resource "aws_iot_topic_rule" "iot_to_lambda" {
  enabled     = true
  name        = replace("${var.namespace}-${var.project_name}-hall-to-lambda", "-", "_")
  sql         = "SELECT hall FROM 'esp32/pub'"
  sql_version = "2016-03-23"

  lambda {
    function_arn = module.lambda.lambda_function_arn
  }
}
