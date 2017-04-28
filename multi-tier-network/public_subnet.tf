resource "aws_subnet" "public" {
  count             = "${length(var.azs)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, count.index + var.subnet_start)}"
  availability_zone = "${element(var.azs, count.index)}"

  tags {
    Name      = "${var.service}-public-${format("%03d", count.index+1)}"
    terraform = true
    module    = "subnet"
  }

  lifecycle {
    create_before_destroy = true
  }

  map_public_ip_on_launch = true
}
