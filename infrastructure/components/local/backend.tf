terraform {
  required_version = "< 2"

  backend "local" {
    path = ".local.tfstate/terraform.tfstate"
  }
}