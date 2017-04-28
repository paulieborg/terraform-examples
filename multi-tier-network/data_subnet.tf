resource "aws_subnet" "data" {
  count             = "${var.three_tier ? length(var.azs) : 0}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, count.index + var.subnet_start + 30)}"
  availability_zone = "${var.azs[count.index]}"

  tags {
    Name      = "${var.service}-data-${format("%03d", count.index+1)}"
    terraform = true
    module    = "data"
  }
}

resource "aws_db_subnet_group" "data" {
  count       = "${var.three_tier ? 1 : 0}"
  name        = "${var.service}-data-subnet-group"
  description = "Subnet group for RDS on ${var.service} stack"

  subnet_ids = [
    "${aws_subnet.data.*.id}",
  ]

  tags {
    terraform = true
    module    = "data"
  }
}
