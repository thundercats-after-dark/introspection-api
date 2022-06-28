resource "aws_apprunner_auto_scaling_configuration_version" "auto-scaling-config" {
  auto_scaling_configuration_name = "introspection-api-config"
  max_concurrency                 = 50
  max_size                        = 3
  min_size                        = 2
}

resource "aws_apprunner_service" "service" {
  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.auto-scaling-config.arn
  service_name                   = "introspection-api"
  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner-ecr-role.arn
    }
    image_repository {
      image_configuration {
        port = 8080
      }
      image_identifier      = "${aws_ecr_repository.introspection-api.repository_url}:latest"
      image_repository_type = "ECR"
    }
  }

  instance_configuration {
    instance_role_arn = aws_iam_role.apprunner-instance-role.arn
  }
}
