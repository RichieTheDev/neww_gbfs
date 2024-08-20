variable "aws_region" {
  description = "The AWS region to deploy the infrastructure in"
  type        = string
  default     = "us-east-1"
}

variable "iam_role_arn" {
  description = "The ARN of the IAM role for the Lambda function"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic for alerts"
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "athena_db_name" {
  description = "The name of the Athena database"
  type        = string
}

variable "glue_db_name" {
  description = "The name of the Glue database"
  type        = string
}

variable "quicksight_user_name" {
  description = "The QuickSight username"
  type        = string
}

variable "quicksight_user_email" {
  description = "The QuickSight user email"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS Account ID"
  type        = string
}
