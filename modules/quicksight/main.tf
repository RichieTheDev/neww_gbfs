# QuickSight User
resource "aws_quicksight_user" "default" {
  # The username for the QuickSight user
  user_name = "gbfs-user"

  # The email address associated with the QuickSight user
  email = "user@example.com"

  # Identity type for the QuickSight user. 'IAM' means using IAM credentials.
  identity_type = "IAM"

  # The role assigned to the QuickSight user. 'ADMIN' provides administrative privileges.
  user_role = "ADMIN"

  # The AWS account ID where QuickSight is set up
  aws_account_id = data.aws_caller_identity.current.account_id

  # The namespace in QuickSight where the user will be created. 'default' is the default namespace.
  namespace = "default"
}

# Athena Workgroup
resource "aws_athena_workgroup" "default" {
  # The name of the Athena workgroup
  name = "gbfs_workgroup"
}

# Athena Named Query
resource "aws_athena_named_query" "trends_query" {
  # The name of the Athena named query
  name = "TrendsOverTime"

  # The database in Athena where the query will be executed
  database = aws_athena_database.gbfs.name

  # The SQL query file for Athena. This file should be located at 'athena_queries/trends.sql'
  query = file("athena_queries/trends.sql")

  # The Athena workgroup in which the query will run
  workgroup = aws_athena_workgroup.default.name
}
