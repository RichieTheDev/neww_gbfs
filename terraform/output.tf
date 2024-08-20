output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "iam_role_arn" {
  value = module.iam_role.role_arn
}

output "lambda_function_name" {
  value = module.lambda.function_name
}

output "cloudwatch_alarms" {
  value = [
    module.cloudwatch.lambda_error_alarm,
    module.cloudwatch.vehicle_count_anomaly
  ]
}

output "athena_database_name" {
  value = module.athena_glue.athena_database_name
}

output "quicksight_user_name" {
  value = module.quicksight.user_name
}

output "sns_topic_arn" {
  value = module.sns.topic_arn
}
