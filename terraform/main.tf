provider "aws" {
  region = "us-east-1"
}
data "aws_caller_identity" "current" {}

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
  glue_db_name   = "my_new_gbfs"
  s3_bucket_name = var.s3_bucket_name
}

module "cloudwatch" {
  source               = "../modules/cloudwatch"
  lambda_function_name = module.lambda.function_name
  sns_topic_arn        = module.sns.topic_arn
}
module "athena" {
  source         = "../modules/athena"
  athena_db_name = "gbfs"
  s3_bucket_name = var.s3_bucket_name
}
module "quicksight" {
  source                = "../modules/quicksight"
  quicksight_user_name  = "gbfs-user"
  quicksight_user_email = "richiemomodu@gmail.com"
  aws_account_id        = data.aws_caller_identity.current.account_id
}
