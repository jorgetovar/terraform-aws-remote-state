output "config" {
  description = "A map containing the following configuration details: The name of the created S3 bucket, the AWS region of the S3 bucket, the ARN of the IAM role created for the backend, and the name of the created DynamoDB table for locking."
  value       = {
    bucket         = aws_s3_bucket.state_bucket.bucket
    region         = data.aws_region.current.name
    role_arn       = aws_iam_role.iam_role.arn
    dynamodb_table = aws_dynamodb_table.state_lock_table.name
  }
}
