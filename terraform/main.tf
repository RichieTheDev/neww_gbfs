provider "aws" {
  region = "us-east-1"
}

# Include the S3 module
module "s3" {
  source = "../modules/s3"
}

# Include the SNS Topic module
module "sns" {
  source = "../modules/sns"
}

# Include the IAM Role module
module "iam_role" {
  source = "../modules/iam_role"
}

# Include the Lambda function module
module "lambda" {
  source         = "../modules/lambda"
  s3_bucket_name = module.s3.bucket_name
  sns_topic_arn  = module.sns.topic_arn
  iam_role_arn   = module.iam_role.role_arn
}

# Include the Glue module
module "glue" {
  source         = "../modules/glue"
  s3_bucket_name = module.s3.bucket_name
  glue_db_name   = "my_glue_database"
}

# Include the CloudWatch module
module "cloudwatch" {
  source               = "../modules/cloudwatch"
  lambda_function_name = module.lambda.function_name
  sns_topic_arn        = module.sns.topic_arn
}

# Include the Athena module
module "athena" {
  source               = "../modules/athena"
  s3_bucket_name       = module.s3.bucket_name
  athena_database_name = "my_athena_database"
}

