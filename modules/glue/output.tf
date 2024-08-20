output "glue_database_name" {
  description = "The name of the Glue catalog database"
  value       = aws_glue_catalog_database.gbfs.name
}

output "glue_table_name" {
  description = "The name of the Glue catalog table"
  value       = aws_glue_catalog_table.gbfs_data.name
}

output "glue_table_database_name" {
  description = "The database name of the Glue catalog table"
  value       = aws_glue_catalog_table.gbfs_data.database_name
}

output "glue_table_s3_location" {
  description = "The S3 location where the Glue catalog table data is stored"
  value       = aws_glue_catalog_table.gbfs_data.storage_descriptor[0].location
}
output "athena_database_name" {
  value = aws_glue_catalog_database.gbfs.name
}
