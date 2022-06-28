terraform {
  required_version = "< 2"

  backend "s3" {
    region         = "us-east-1"
    bucket         = "thundercats-after-dark-tfstate"
    dynamodb_table = "thundercats-after-dark-tfstate"
    key            = "introspection-api"
  }
}
