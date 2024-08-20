# Define a QuickSight user in your AWS account
resource "aws_quicksight_user" "default" {
  # The username for the QuickSight user, provided via a variable
  user_name = var.quicksight_user_name

  # The email address associated with the QuickSight user
  email = var.quicksight_user_email

  # Specifies that the user will authenticate via an IAM role or user
  identity_type = "IAM"

  # Assign the user the "ADMIN" role, which provides full access to QuickSight resources
  user_role = "ADMIN"

  # The AWS account ID where the QuickSight user is being created
  aws_account_id = var.aws_account_id

  # The QuickSight namespace where the user will be created, typically "default"
  namespace = "default"
}
