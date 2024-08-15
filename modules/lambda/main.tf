# Lambda Function
resource "aws_lambda_function" "gbfs_processor" {
  # The name of the Lambda function
  function_name = "gbfs_processor"

  # IAM role that the Lambda function will assume
  role = var.iam_role_arn

  # Specifies the function handler in the Lambda code, in the format "file_name.function_name"
  handler = "index.handler"

  # The runtime environment for the Lambda function (Python 3.8 in this case)
  runtime = "python3.8"

  # Environment variables that will be available to the Lambda function at runtime
  environment {
    variables = {
      S3_BUCKET_NAME = var.s3_bucket_name # Name of the S3 bucket to use
      SNS_TOPIC_ARN  = var.sns_topic_arn  # ARN of the SNS topic for notifications
    }
  }

  # S3 bucket and key where the Lambda function code is stored
  s3_bucket = var.s3_bucket_name
  s3_key    = "lambda/function.zip" # Path to the Lambda deployment package in the S3 bucket
}
