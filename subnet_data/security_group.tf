variable "vpc_id" {
   default = "vpc-44299320"
}

data "aws_subnet" "selected" {
  vpc_id = "${var.vpc_id}"
  filter {
    name   = "tag:Name"
    values = ["my-vpc-subnet-public-ap-southeast-2a"]
  }

}

resource "aws_security_group" "subnet" {
  vpc_id = "${data.aws_subnet.selected.vpc_id}"

  ingress {
    cidr_blocks = ["${data.aws_subnet.selected.cidr_block}"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
}

