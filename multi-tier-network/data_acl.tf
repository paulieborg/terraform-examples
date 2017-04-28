resource "aws_network_acl" "data" {
  count      = "${var.three_tier ? 1 : 0}"
  vpc_id     = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.data.*.id}"]

  ### Inbound Rules ###
  #####################

  # DB connections inbound
  ingress {
    rule_no    = 3001
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "${aws_vpc.main.cidr_block}"
    from_port  = "${var.db_port}"
    to_port    = "${var.db_port}"
  }

  ### Outbound Rules ###
  ######################


  ### Ephemeral Ports ###
  #######################

  tags {
    Name      = "${var.service}-acl-data"
    terraform = true
    module    = "app"
  }
}
