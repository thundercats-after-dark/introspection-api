provider "aws" {
  region                      = "us-east-1"
  access_key                  = "not used"
  secret_key                  = "not used"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    dynamodb = "http://localhost:8000"
  }
}