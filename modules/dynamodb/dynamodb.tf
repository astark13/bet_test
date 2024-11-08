# modules/dynamodb/main.tf
resource "aws_dynamodb_table" "main" {
  name           = "${var.env_name}-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ID"
  range_key      = "userId"
  point_in_time_recovery {
    enabled = true
  }
  ttl {
    attribute_name = "ttl"
    enabled        = true
  }
  attribute {
    name = "ID"
    type = "S"
  }
  attribute {
    name = "userId"
    type = "S"
  }
  tags = var.tags
}

output "table_name" {
  value = aws_dynamodb_table.main.name
}