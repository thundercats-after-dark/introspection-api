resource "aws_ecr_repository" "introspection-api" {
  name                 = "introspection-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
