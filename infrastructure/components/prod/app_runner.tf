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

data "aws_route53_zone" "cloud-thundercats-dev-zone" {
  name = "cloud.thundercats.dev"
}

resource "aws_apprunner_custom_domain_association" "introspection-api-domain" {
  domain_name = "introspect.cloud.thundercats.dev"
  service_arn = aws_apprunner_service.service.arn
}

# must `terraform apply -target="aws_apprunner_service.service" -target="aws_apprunner_custom_domain_association.introspection-api-domain"
# the first time due to for_each
resource "aws_route53_record" "introspection-api-validation-cnames" {
  for_each = {for record in aws_apprunner_custom_domain_association.introspection-api-domain.certificate_validation_records : record.name => record}

  name    = each.value.name
  type    = each.value.type
  zone_id = data.aws_route53_zone.cloud-thundercats-dev-zone.zone_id
  ttl     = 3600
  records = [each.value.value]
}

resource "aws_route53_record" "introspection-api-cname" {
  name    = "introspect.cloud.thundercats.dev"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.cloud-thundercats-dev-zone.zone_id
  ttl     = 3600
  records = [
    aws_apprunner_service.service.service_url
  ]
}
