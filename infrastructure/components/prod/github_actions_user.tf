data "aws_iam_policy_document" "github-actions-assume-role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:chadxz/my-api-golang:*"]
    }
  }
}

resource "aws_iam_role" "github-actions" {
  name               = "github-actions-deploy"
  assume_role_policy = data.aws_iam_policy_document.github-actions-assume-role.json
}

resource "aws_iam_role_policy_attachment" "github-actions-admin" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role = aws_iam_role.github-actions.name
}