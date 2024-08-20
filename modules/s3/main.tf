# S3 Bucket for GBFS Data
resource "aws_s3_bucket" "gbfs_s3" {
  # Name of the S3 bucket
  bucket = "my-gbfs-test-bucket"

  # Tags for identifying and organizing the bucket
  tags = {
    Name        = "My bucket" # A human-readable name for the bucket
    Environment = "Dev"       # Environment tag for bucket categorization
  }
}

# S3 Bucket for QuickSight Data
resource "aws_s3_bucket" "quicksight_data" {
  # Name of the S3 bucket
  bucket = "quicksight-data-gbfs"

  # Tags for identifying and organizing the bucket
  tags = {
    Name = "QuickSight Data" # A human-readable name for the bucket
  }
}
