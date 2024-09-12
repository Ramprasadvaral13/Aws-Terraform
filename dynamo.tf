resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamo.name
  billing_mode = "PAY_PER_REQUEST"

  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"  # 'S' stands for string
  }

  tags = {
    Name        = "Terraform State Lock"
    Environment = "Dev"
  }
}
