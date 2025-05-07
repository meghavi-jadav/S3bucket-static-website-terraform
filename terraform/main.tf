terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws"{
    region = var.aws_region
}

resource "aws_s3_bucket" "static_website" {
    bucket = var.bucket_name

    website {
        index_document = "index.html"
    }

    force_destroy = true

}

resource "aws_s3_bucket_policy" "public_read" {
    bucket = aws_s3_bucket.static_website.id
    policy = data.aws_iam_policy_document.public_read.json
}

data "aws_iam_policy_document" "public_read" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.static_website.arn}/*"
    ]
  }
}
