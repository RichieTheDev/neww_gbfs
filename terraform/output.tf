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
  value = module.glue.athena_database_name # Ensure this attribute exists in the Glue module
}
