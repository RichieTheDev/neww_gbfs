provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source = "../modules/s3"
}

module "sns" {
  source = "../modules/sns"
}

module "iam_role" {
  source = "../modules/iam_role"
}

module "lambda" {
  source         = "../modules/lambda"
  s3_bucket_name = module.s3.bucket_name
  sns_topic_arn  = module.sns.topic_arn
  iam_role_arn   = module.iam_role.role_arn
}

module "glue" {
  source         = "../modules/glue"
  s3_bucket_name = module.s3.bucket_name
}

module "cloudwatch" {
  source               = "../modules/cloudwatch"
  lambda_function_name = module.lambda.function_name
  sns_topic_arn        = module.sns.topic_arn
}
