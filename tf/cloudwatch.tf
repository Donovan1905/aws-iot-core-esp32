resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name                = "${var.project_name}-hall-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "Hall"
  namespace                 = "esp32/pub"
  period                    = 10
  statistic                 = "Maximum"
  threshold                 = 700
  alarm_description         = "This metric monitors ec2 cpu utilization"
  dimensions = {
    DeviceId = "ESP32"
  }
  insufficient_data_actions = []
  alarm_actions = [
    aws_sns_topic.iot-topic-alarm.arn
  ]
}
