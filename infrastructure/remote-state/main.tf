# name should match `terraform.backend["s3"].bucket` from ../components/prod.tf
resource "aws_s3_bucket" "thundercats-after-dark-tfstate" {
  bucket = "thundercats-after-dark-tfstate"

  lifecycle {
    prevent_destroy = true
  }
}

# name should match `terraform.backend["s3"].dynamodb_table` from ../components/prod.tf
resource "aws_dynamodb_table" "thundercats-after-dark-tfstate" {
  name = "thundercats-after-dark-tfstate"
  hash_key = "LockID"
  read_capacity = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }
}
