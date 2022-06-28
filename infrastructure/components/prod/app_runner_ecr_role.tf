data "aws_iam_policy_document" "apprunner-ecr-assume-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["build.apprunner.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "apprunner-ecr-role" {
  name               = "AppRunnerECRAccessRole"
  assume_role_policy = data.aws_iam_policy_document.apprunner-ecr-assume-policy.json
}

resource "aws_iam_role_policy_attachment" "apprunner-ecr-role-attachment" {
  role       = aws_iam_role.apprunner-ecr-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}
