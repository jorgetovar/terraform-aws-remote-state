# Terraform Module: S3 Backend with DynamoDB Locking

This Terraform module manages an S3 backend along with a DynamoDB table for locking.

## Module Input Variables

- `namespace` (optional): Project identifier. Defaults to "jt-aws-terraform".
- `principal_arns` (optional): A list of principal ARNs allowed to assume the IAM role to deploy the backend. Defaults to the ARN of the caller identity.
- `force_destroy_state` (optional): Force destroy the bucket containing state files? Defaults to true.

## S3 Bucket Resource

This module creates an S3 bucket with the following configurations:

- Bucket name: `<namespace>-state-bucket`
- Versioning enabled: `true`
- Server-side encryption enabled using AWS KMS with the specified KMS key.

## DynamoDB Table Resource

This module creates a DynamoDB table with the following configurations:

- Table name: `<namespace>-state-lock`
- Billing mode: PAY_PER_REQUEST
- Hash key: "LockID"

## IAM Role and Policy

This module creates an IAM role and policy for the Terraform backend. The IAM role allows the specified principal ARNs to assume the role and provides the necessary permissions to interact with the S3 bucket and the DynamoDB table.

### IAM Role Details:

- Role name: `<namespace>-tf-assume-role`
- Assume role policy: Allows the specified principal ARNs to assume the role.

### IAM Policy Details:

The IAM policy attached to the IAM role grants the following permissions:

- For S3 bucket:
    - Action: s3:ListBucket
    - Resource: `<namespace>-state-bucket`

    - Action: s3:GetObject, s3:PutObject, s3:DeleteObject
    - Resource: `<namespace>-state-bucket/*`

- For DynamoDB table:
    - Action: dynamodb:GetItem, dynamodb:PutItem, dynamodb:DeleteItem
    - Resource: `<namespace>-state-lock`


## Outputs

- `config`: A map containing the following configuration details:
    - `bucket`: The name of the created S3 bucket.
    - `region`: The AWS region of the S3 bucket.
    - `role_arn`: The ARN of the IAM role created for the backend.
    - `dynamodb_table`: The name of the created DynamoDB table for locking.

---
*Note: This module assumes you have an AWS provider already configured in your main Terraform configuration.*
