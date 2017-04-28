resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.account_name}-tf"
  region = "${var.region}"
  acl = "private"
  policy = "${data.aws_iam_policy_document.s3_bucket_policy.json}"

  tags {
    Name = "${var.account_name}-tf"
    terraform = true
    myob_aws_account_template = true
  }
}

data "aws_iam_policy_document" "s3_bucket_policy" {

  statement {
    sid = "DenyUnencryptedAccess"
    effect = "Deny",
    principals = {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.account_name}-tf/*"
    ]
    condition = {
      test = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values = [
        "aws:kms"]
    }
  }

}
