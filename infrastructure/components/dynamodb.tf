resource "aws_dynamodb_table" "dynamodb-table-my-api-golang" {
  name           = "my-api-golang"
  billing_mode   = "PAY_PER_REQUEST"
  table_class    = "STANDARD"
  stream_enabled = false

  hash_key = "id"
  attribute {
    name = "id"
    type = "S"
  }

  lifecycle {
    # these are managed automatically when using "PAY_PER_REQUEST" billing mode
    ignore_changes = [read_capacity, write_capacity]
  }
}