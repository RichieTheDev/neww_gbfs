output "athena_database_name" {
  description = "The name of the Athena database"
  value       = aws_athena_database.example.name
}


output "athena_workgroup_name" {
  description = "The name of the Athena workgroup"
  value       = aws_athena_workgroup.default.name
}

output "athena_named_query_id" {
  description = "The ID of the Athena named query"
  value       = aws_athena_named_query.trends_query.id
}


