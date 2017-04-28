data "aws_region" "current" {
  current = true
}

resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name                  = "${var.name}-vpc"
    terraform             = true
    ops_terraform_modules = true
    module                = "vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name                      = "${var.name}-gateway"
    terraform                 = true
    myob_aws_account_template = true
    module                    = "vpc"
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    principals = {
      type = "Service"

      identifiers = [
        "vpc-flow-logs.amazonaws.com",
      ]
    }

    actions = [
      "sts:AssumeRole",
    ]
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

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role" "flow_log" {
  name               = "${var.name}-vpc-flow-log"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy" "flow_log_policy" {
  name   = "allow_cw_logs"
  role   = "${aws_iam_role.flow_log.id}"
  policy = "${data.aws_iam_policy_document.flow_log_statements.json}"
}

resource "aws_cloudwatch_log_group" "main_log_group" {
  name              = "${var.name}-flow-logs"
  retention_in_days = "${var.vpc_flow_log_retention}"
}

resource "aws_flow_log" "main_flow_log" {
  log_group_name = "${aws_cloudwatch_log_group.main_log_group.name}"
  iam_role_arn   = "${aws_iam_role.flow_log.arn}"
  vpc_id         = "${aws_vpc.main.id}"
  traffic_type   = "${var.vpc_flow_log_traffic_type}"
}

resource "aws_vpc_dhcp_options" "main" {
  domain_name = "${data.aws_region.current.name}.compute.internal"

  domain_name_servers = [
    "AmazonProvidedDNS",
  ]

  tags {
    Name                  = "${var.name}-dhcp"
    terraform             = true
    ops_terraform_modules = true
    module                = "vpc"
  }
}

resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.main.id}"
}
