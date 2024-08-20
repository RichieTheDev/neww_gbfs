# Define an Athena database for GBFS (General Bikeshare Feed Specification) data
resource "aws_athena_database" "gbfs" {
  # The name of the Athena database, provided via a variable
  name = var.athena_db_name

  # The S3 bucket where query results will be stored, provided via a variable
  bucket = var.s3_bucket_name
}

# Create an Athena workgroup named "gbfs_workgroup"
resource "aws_athena_workgroup" "default" {
  # The name of the workgroup
  name = "gbfs_workgroup"
}

# Define an Athena named query to create an external table for trends data
resource "aws_athena_named_query" "create_trends_table" {
  # The name of the query
  name = "create_trends_table"

  # The Athena database where the query will be executed
  database = aws_athena_database.gbfs.name

  # The SQL query to create an external table for storing trends data in CSV format
  query = <<EOF
    CREATE EXTERNAL TABLE IF NOT EXISTS trends (
      column_name STRING
    )
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE
    LOCATION 's3://${var.s3_bucket_name}/athena/tables/trends.csv';
  EOF

  # The workgroup in which this query will be executed
  workgroup = aws_athena_workgroup.default.name
}

# Define another Athena named query to run the trends query
resource "aws_athena_named_query" "trends_query" {
  # The name of the query
  name = "TrendsOverTime"

  # The Athena database where the query will be executed
  database = aws_athena_database.gbfs.name

  # The SQL query that calculates trends over time, read from an external file
  query = file("${path.module}/../../athena_queries/trends.sql")


  # The workgroup in which this query will be executed
  workgroup = aws_athena_workgroup.default.name
}
