# variables.tf

variable "iam_role_arn" {
  description = "The ARN of the IAM role for the Lambda function"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket where the Lambda function code is stored"
  type        = string
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic for alerts"
  type        = string
}
