# SNS Topic for Alerts
resource "aws_sns_topic" "gbfs_alerts" {
  name = "gbfs-alerts"
}