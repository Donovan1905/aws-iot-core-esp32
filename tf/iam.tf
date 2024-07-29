data "aws_iam_policy_document" "assume_role_policy_lambda" {
  statement {
    sid    = ""
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "policy_s3" {
  statement {
    sid    = "LambdaLoggingPolicy"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }

  statement {
  sid    = "LambdaMetricsPolicy"
  effect = "Allow"
  actions = [
    "cloudwatch:PutMetricData",
  ]
  resources = [
    "*"
  ]
  }

  statement {
  sid    = "LambdaIoTPolicy"
  effect = "Allow"
  actions = [
    "iot:Publish",
  ]
  resources = [
    "*"
  ]
  }

}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "${var.project_name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_lambda.json
}

resource "aws_iam_role_policy" "lambda_policy" {
  policy = data.aws_iam_policy_document.policy_s3.json
  role   = aws_iam_role.iam_for_lambda.id
}
