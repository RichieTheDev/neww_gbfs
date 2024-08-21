# Define a Glue catalog database to store metadata for GBFS data
resource "aws_glue_catalog_database" "gbfs" {
  # The name of the Glue database, provided via a variable
  name = "mycatalogdatabase"

}

# Define a Glue catalog table to represent the GBFS data stored in S3
resource "aws_glue_catalog_table" "gbfs_data" {
  # The name of the Glue table
  name = "my_gbfs_data"

  # The Glue database where this table will be created
  database_name = aws_glue_catalog_database.gbfs.name

  # Define the storage descriptor for the table, which describes how data is stored
  storage_descriptor {
    # The S3 location where the data files are stored
    location = "s3://${var.s3_bucket_name}/athena-tables/"

    # Input format class that tells Glue how to read the data
    input_format = "org.apache.hadoop.mapred.TextInputFormat"

    # Output format class that tells Glue how to write the data
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    # Define the columns of the table, each with a name and data type
    columns {
      # Name of the column
      name = "column_name"

      # Data type of the column
      type = "string"
    }
  }
}
