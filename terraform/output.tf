output "bucket_name" {
  value = module.s3.bucket_name
}

output "sns_topic_arn" {
  value = module.sns.topic_arn
}

output "lambda_function_name" {
  value = module.lambda.function_name
}

output "athena_database_name" {
  value = module.athena.athena_db_name
}

output "glue_database_name" {
  value = module.glue.glue_db_name
}


output "quicksight_user_name" {
  value = module.quicksight.quicksight_user_name
}
