# This resource creates a CloudWatch alarm that monitors the "Errors" metric for a specific Lambda function.
# If the number of errors exceeds the threshold (1 in this case), the alarm will trigger and notify the specified SNS topic.
resource "aws_cloudwatch_metric_alarm" "lambda_error_alarm" {
  alarm_name          = "LambdaErrorAlarm"                                     # Name of the alarm
  comparison_operator = "GreaterThanThreshold"                                 # Trigger alarm if the metric is greater than the threshold
  evaluation_periods  = "1"                                                    # Number of periods over which data is compared to the threshold
  metric_name         = "Errors"                                               # The metric to monitor (in this case, Lambda errors)
  namespace           = "AWS/Lambda"                                           # The namespace of the metric, AWS/Lambda for Lambda functions
  period              = "300"                                                  # The period (in seconds) over which the specified statistic is applied
  statistic           = "Sum"                                                  # The statistic to apply to the metric (Sum of errors in this case)
  threshold           = "1"                                                    # The threshold value to compare the metric against
  alarm_description   = "This alarm fires when the Lambda function has errors" # Description of the alarm's purpose
  alarm_actions       = [var.sns_topic_arn]                                    # List of actions (e.g., notifying an SNS topic) to execute when the alarm state is triggered

  dimensions = {
    FunctionName = var.lambda_function_name # Dimension used to filter the metric (Lambda function name in this case)
  }
}

# This resource creates a CloudWatch alarm that monitors the "VehicleCount" metric for the GBFS data.
# If the vehicle count exceeds the threshold (100 in this case), the alarm will trigger and notify the specified SNS topic.
resource "aws_cloudwatch_metric_alarm" "vehicle_count_anomaly" {
  alarm_name          = "VehicleCountAnomaly"                                           # Name of the alarm
  comparison_operator = "GreaterThanThreshold"                                          # Trigger alarm if the metric is greater than the threshold
  evaluation_periods  = "1"                                                             # Number of periods over which data is compared to the threshold
  metric_name         = "VehicleCount"                                                  # The metric to monitor (in this case, vehicle count)
  namespace           = "GBFS/VehicleCount"                                             # The namespace of the metric, GBFS/VehicleCount for custom vehicle metrics
  period              = "300"                                                           # The period (in seconds) over which the specified statistic is applied
  statistic           = "Sum"                                                           # The statistic to apply to the metric (Sum of vehicle count in this case)
  threshold           = "100"                                                           # The threshold value to compare the metric against
  alarm_description   = "This alarm fires when the vehicle count exceeds the threshold" # Description of the alarm's purpose
  alarm_actions       = [var.sns_topic_arn]                                             # List of actions (e.g., notifying an SNS topic) to execute when the alarm state is triggered

  dimensions = {
    Provider = "AllProviders" # Dimension used to filter the metric (Vehicle provider in this case)
  }
}
