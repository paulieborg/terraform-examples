data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    principals = {
      type = "Service"

      identifiers = [
        "vpc-flow-logs.amazonaws.com",
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "flow_log_statements" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "flow_log" {
  name               = "${var.service}-vpc-flow-log"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy" "flow_log_policy" {
  name   = "allow_cw_logs"
  role   = "${aws_iam_role.flow_log.id}"
  policy = "${data.aws_iam_policy_document.flow_log_statements.json}"
}
