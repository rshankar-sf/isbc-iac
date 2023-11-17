module "sns_topic" {
  source  = "terraform-aws-modules/sns/aws"
  name    = "isbc-sns-api"
}

# resource "aws_sns_topic_subscription" "email_subscription" {
#   topic_arn = module.sns_topic.topic_arn
#   protocol  = "email"
#   endpoint  = "shankar.r@sourcefuse.com"
# }

resource "aws_sns_topic_policy" "my_isbc_sns_topic_policy" {
  arn    = module.sns_topic.topic_arn
  policy = data.aws_iam_policy_document.my_custom_sns_policy_document.json
}

data "aws_iam_policy_document" "my_custom_sns_policy_document" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",  
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      module.sns_topic.topic_arn,
    ]

    sid = "__default_statement_ID"
  }
}
