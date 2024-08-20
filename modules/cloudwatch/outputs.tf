output "lambda_error_alarm" {
  value = aws_cloudwatch_metric_alarm.lambda_error_alarm
}

output "vehicle_count_anomaly" {
  value = aws_cloudwatch_metric_alarm.vehicle_count_anomaly
}
