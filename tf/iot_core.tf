resource "aws_iot_thing" "esp32" {
  name = "${var.namespace}-${var.project_name}-esp32"
}

resource "aws_iot_thing_principal_attachment" "iot_attachment" {
  principal = aws_iot_certificate.cert.arn
  thing = aws_iot_thing.esp32.name
}

data "aws_iam_policy_document" "pubsub" {
  statement {
    effect    = "Allow"
    actions   = ["iot:*"]
    resources = ["*"]
  }
}

resource "aws_iot_policy" "pubsub" {
  name   = "PubSubToAnyTopic"
  policy = data.aws_iam_policy_document.pubsub.json
}

resource "aws_iot_policy_attachment" "att" {
  policy = aws_iot_policy.pubsub.name
  target = aws_iot_certificate.cert.arn
}