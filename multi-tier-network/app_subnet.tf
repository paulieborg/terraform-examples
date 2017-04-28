resource "aws_subnet" "app" {
  count             = "${length(var.azs)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, count.index + var.subnet_start+20)}"
  availability_zone = "${element(var.azs, count.index)}"

  tags {
    Name      = "${var.service}-app-${format("%03d", count.index+1)}"
    terraform = true
    module    = "subnet"
  }

  lifecycle {
    create_before_destroy = true
  }
}
