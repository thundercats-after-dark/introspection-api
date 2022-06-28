data "aws_iam_policy_document" "apprunner-instance-assume-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["tasks.apprunner.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "apprunner-instance-role" {
  name               = "AppRunnerInstanceRole"
  assume_role_policy = data.aws_iam_policy_document.apprunner-instance-assume-policy.json
}

// TODO: Add any permissions here that our application needs at runtime
