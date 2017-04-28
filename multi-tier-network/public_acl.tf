resource "aws_network_acl" "public" {
  vpc_id     = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.public.*.id}"]

  ### Inbound Rules ###
  #####################

  # HTTPS inbound from internet
  ingress {
    rule_no    = 2001
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ### Outbound Rules ###
  ######################

  # HTTP out to VPC
  egress {
    rule_no    = 2001
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "${aws_vpc.main.cidr_block}"
    from_port  = 80
    to_port    = 80
  }
  # HTTPS out to VPC
  egress {
    rule_no    = 2002
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "${aws_vpc.main.cidr_block}"
    from_port  = 443
    to_port    = 443
  }
  tags {
    Name      = "${var.service}-acl-elb"
    terraform = true
    module    = "app"
  }
}
