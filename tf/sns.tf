resource "aws_sns_topic" "iot-topic-alarm" {
  name = "${var.project_name}-iot-topic-alarm"
}

resource "aws_sns_topic_subscription" "lambda-target" {
  topic_arn = aws_sns_topic.iot-topic-alarm.arn
  protocol  = "lambda"
  endpoint  = module.lambda-iot-send-command.lambda_function_arn
}

resource "aws_lambda_permission" "allow_sns_invoke" {
  statement_id  = "AllowSNSInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda-iot-send-command.lambda_function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.iot-topic-alarm.arn
}
