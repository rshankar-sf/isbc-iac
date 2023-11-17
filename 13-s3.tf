module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"

  bucket = "isbc-api-s3bucket-dev"

  tags = {
    project = "isbc"
    Environment = "dev"
  }
}


module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"

  name = "isbc-api-sqs-dev"

  tags = {
    project = "isbc"
    Environment = "dev"
  }
}


data "aws_iam_policy_document" "isbc_s3_policy" {
  statement {
            sid = "example-statement-ID"
            effect = "Allow"
            principals {
                type        = "Service"
                identifiers = ["s3.amazonaws.com"]
            }
            actions = [
                "SQS:SendMessage" 
            ]
            resources = ["arn:aws:sqs:ap-south-1:441626701516:${module.sqs.queue_name}"]
            condition {
                test     = "ArnLike"
                variable = "aws:SourceArn"
                values   = ["arn:aws:s3:*:*:${module.s3_bucket.s3_bucket_id}"]
            }
            condition {
                test     = "StringEquals"
                variable = "aws:SourceAccount"
                values   = ["441626701516"]
            }
    }
}

resource "aws_sqs_queue_policy" "isbc_policy" {
  queue_url = module.sqs.queue_id
  policy    = data.aws_iam_policy_document.isbc_s3_policy.json
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.s3_bucket.s3_bucket_id

  queue {
    queue_arn     = module.sqs.queue_arn
    events        = ["s3:ObjectCreated:Put"]
    # filter_suffix = ".log"
  }
}

resource "aws_sns_topic_subscription" "isbc_sqs_target" {
  topic_arn = module.sns_topic.topic_arn
  protocol  = "sqs"
  endpoint  = module.sqs.queue_arn
}

module "sqs-comprehend" {
  source  = "terraform-aws-modules/sqs/aws"

  name = "isbc-api-comprehend-sqs-dev"

  tags = {
    project = "isbc"
    Environment = "dev"

  }
}