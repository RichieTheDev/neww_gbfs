# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_execution" {
  name = "lambda_execution_role"

  # Define the trust policy that allows Lambda to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com" # Allows AWS Lambda to assume this role
        }
      }
    ]
  })
}

# Attach the basic execution role policy to the Lambda execution role
resource "aws_iam_role_policy_attachment" "lambda_execution_policy" {
  role       = aws_iam_role.lambda_execution.name                                 # IAM role to attach the policy to
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" # Predefined AWS policy for Lambda basic execution
}

# Create a custom IAM policy for S3 access specific to this Lambda function
resource "aws_iam_policy" "lambda_s3_policy" {
  name = "lambda_s3_policy" # Name of the IAM policy

  # Define the policy JSON for S3 access
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"], # Allowed actions for S3
        Resource = [
          "arn:aws:s3:::my-gbfs-test-bucket/lambda/*", # Allows access to objects in the specific path under the bucket
          "arn:aws:s3:::my-gbfs-test-bucket"           # Allows access to the bucket itself
        ]
      }
    ]
  })
}

# Attach the custom S3 access policy to the Lambda execution role
resource "aws_iam_role_policy_attachment" "lambda_attach_s3_policy" {
  role       = aws_iam_role.lambda_execution.name  # IAM role to attach the policy to
  policy_arn = aws_iam_policy.lambda_s3_policy.arn # ARN of the custom S3 policy
}

# Attach the full SNS access policy to the Lambda execution role
resource "aws_iam_role_policy_attachment" "lambda_sns_policy" {
  role       = aws_iam_role.lambda_execution.name            # IAM role to attach the policy to
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess" # Predefined AWS policy for full SNS access
}
