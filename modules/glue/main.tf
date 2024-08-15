resource "aws_glue_catalog_database" "gbfs" {
  name = "my_new_gbfs" # Name of the Glue catalog database
}

resource "aws_glue_catalog_table" "gbfs_data" {
  name          = "my_gbfs_data"                      # Name of the Glue catalog table
  database_name = aws_glue_catalog_database.gbfs.name # Reference to the Glue catalog database

  storage_descriptor {
    location      = "s3://${var.s3_bucket_name}/athena-tables/"                  # S3 location for data
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"                   # Format for reading input data
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat" # Format for writing output data

    # Define the schema with columns and types
    columns {
      name = "column_name" # Column for unspecified data
      type = "string"      # Data type of the column
    }
  }
}

resource "aws_athena_database" "gbfs" {
  name   = "gbfs"             # Name of the Athena database
  bucket = var.s3_bucket_name # S3 bucket for Athena results

}
resource "aws_athena_table" "trends" {
  name          = "trends"
  database_name = aws_athena_database.gbfs.name
  bucket        = var.s3_bucket_name
  key           = "athena/tables/trends.csv"
  format        = "CSV"
  columns {
    name = "column_name"
    type = "string"
  }
}
