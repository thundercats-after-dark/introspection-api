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
  name               = "IntrospectionAPIInstanceRole"
  assume_role_policy = data.aws_iam_policy_document.apprunner-instance-assume-policy.json
}

// https://docs.amazonaws.cn/en_us/amazondynamodb/latest/developerguide/iam-policy-example-data-crud.html
data "aws_iam_policy_document" "apprunner-instance-dynamodb-policy" {
  statement {
    sid     = "DynamoDBTableAccess"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:ConditionCheckItem",
      "dynamodb:PutItem",
      "dynamodb:DescribeTable",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem"
    ]
    resources = [
      "arn:aws:dynamodb:us-east-1:619705995164:table/introspection-api"
    ]
  }
  statement {
    sid     = "DynamoDBIndexAndStreamAccess"
    actions = [
      "dynamodb:GetShardIterator",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:ListStreams"
    ]
    resources = [
      "arn:aws:dynamodb:us-east-1:619705995164:table/introspection-api/index/*",
      "arn:aws:dynamodb:us-east-1:619705995164:table/introspection-api/stream/*"
    ]
  }
  statement {
    sid     = "DynamoDBListAndDescribeAccess"
    actions = [
      "dynamodb:List*",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive"
    ]
    resources = [
      "arn:aws:dynamodb:us-east-1:619705995164:*"
    ]
  }
}

resource "aws_iam_policy" "apprunner-instance-dynamodb-policy" {
  name   = "IntrospectionAPIDynamoDBPolicy"
  policy = data.aws_iam_policy_document.apprunner-instance-dynamodb-policy.json
}

resource "aws_iam_role_policy_attachment" "apprunner-instance-dynamodb-policy-attachment" {
  policy_arn = aws_iam_policy.apprunner-instance-dynamodb-policy.arn
  role       = aws_iam_role.apprunner-instance-role.name
}
