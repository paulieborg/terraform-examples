resource "aws_network_acl" "app" {
  vpc_id     = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.app.*.id}", "${aws_subnet.app.*.id}"]

  ### Inbound Rules ###
  #####################

  # NTP inbound
  ingress {
    rule_no    = 1001
    protocol   = "udp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 123
    to_port    = 123
  }
  # HTTPS traffic in from vpc
  ingress {
    rule_no    = 2001
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "${aws_vpc.main.cidr_block}"
    from_port  = 443
    to_port    = 443
  }
  # SSH connections from Management Subnet
  ingress {
    rule_no    = 9001
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "192.168.255.0/24"
    from_port  = 22
    to_port    = 22
  }

  ### Outbound Rules ###
  ######################

  # NTP outbound
  egress {
    rule_no    = 1001
    protocol   = "udp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 123
    to_port    = 123
  }
  # Splunk logger
  egress {
    rule_no    = 1002
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "${var.log_forwarder_port}"
    to_port    = "${var.log_forwarder_port}"
  }
  # HTTP out to internet
  egress {
    rule_no    = 2001
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  # HTTPS out to internet
  egress {
    rule_no    = 2002
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
  # DB connections out to vpc
  egress {
    rule_no    = 3001
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "${aws_vpc.main.cidr_block}"
    from_port  = "${var.db_port}"
    to_port    = "${var.db_port}"
  }

  ### Ephemeral Ports ###
  #######################

  # inbound return traffic
  ingress {
    rule_no    = 9001
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  # outbound return traffic
  egress {
    rule_no    = 9001
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  tags {
    Name      = "${var.service}-acl-app"
    terraform = true
    module    = "app"
  }
}
