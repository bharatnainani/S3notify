

resource "aws_s3_bucket" "master_cloudtrail_bucket" {
  bucket        = "${var.cloudtrail-s3-bucket}-${var.environment}"
  force_destroy = true

  versioning {
    enabled = true
  }

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.cloudtrail-s3-bucket}-${var.environment}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.cloudtrail-s3-bucket}-${var.environment}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Sid": "AWSGlueReadLogs",
            "Effect": "Allow",
            "Principal": {
              "Service": "glue.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.cloudtrail-s3-bucket}-${var.environment}/*"
        }
    ]
}
POLICY
}