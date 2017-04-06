data "aws_vpc" "selected" {
  tags {
    "Name" = "${var.environment}-vpc"
  }

}

data "aws_subnet" "privates" {
  vpc_id = "${data.aws_vpc.selected.id}"
  availability_zone = "${element(split(",", var.availability_zones), count.index)}"

  tags {
    "Name" = "${var.environment}-vpc-${format("internal-%03d", count.index+1)}"
  }

  count = "${length(split(",", var.availability_zones))}"
}

resource "aws_security_group" "subnet" {
  name = "${var.environment}-sg"
  vpc_id = "${data.aws_vpc.selected.id}"

  ingress {
    cidr_blocks = [
      "${data.aws_subnet.privates.*.cidr_block}"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
}