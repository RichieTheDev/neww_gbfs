provider "aws" {
  region = var.aws_region
}

# Include the S3 module
module "s3" {
  source = "../modules/s3"
}

# Include the IAM Role module
module "iam_role" {
  source = "../modules/iam_role"
}

# Include the Lambda function module
module "lambda" {
  source         = "../modules/lambda"
  iam_role_arn   = module.iam_role.role_arn
  s3_bucket_name = module.s3.bucket_name
  sns_topic_arn  = module.sns.topic_arn
}

# Include the CloudWatch module
module "cloudwatch" {
  source               = "../modules/cloudwatch"
  lambda_function_name = module.lambda.function_name
  sns_topic_arn        = module.sns.topic_arn
}

# Include the Athena and Glue module
module "athena_glue" {
  source         = "../modules/glue"
  s3_bucket_name = module.s3.bucket_name
  glue_db_name   = var.glue_db_name
}

# Include the QuickSight module
module "quicksight" {
  source                = "../modules/quicksight"
  quicksight_user_name  = var.quicksight_user_name
  quicksight_user_email = var.quicksight_user_email
  aws_account_id        = var.aws_account_id
}

# Include the SNS Topic module
module "sns" {
  source = "../modules/sns"
}
