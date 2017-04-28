resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name      = "${var.service}-vpc"
    terraform = true
    module    = "vpc"
  }
}

resource "aws_route_table" "ig_route" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name      = "${var.service}-default-public-routes"
    terraform = true
    module    = "vpc"
  }
}

resource "aws_main_route_table_association" "public_route" {
  vpc_id         = "${aws_vpc.main.id}"
  route_table_id = "${aws_route_table.ig_route.id}"
}

resource "aws_cloudwatch_log_group" "main_log_group" {
  name              = "${var.service}-flow-logs"
  retention_in_days = "${var.flow_log_retention}"
}

resource "aws_flow_log" "main_flow_log" {
  log_group_name = "${aws_cloudwatch_log_group.main_log_group.name}"
  iam_role_arn   = "${aws_iam_role.flow_log.arn}"
  vpc_id         = "${aws_vpc.main.id}"
  traffic_type   = "${var.flow_log_traffic_type}"
}
