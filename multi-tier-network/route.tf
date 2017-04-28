resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name      = "${var.service}-public-route"
    terraform = true
    module    = "app"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name      = "${var.service}-private-route"
    terraform = true
    module    = "db"
  }
}

resource "aws_route_table_association" "app" {
  count          = "${aws_subnet.app.count}"
  subnet_id      = "${element(aws_subnet.app.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public" {
  count          = "${aws_subnet.public.count}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "data" {
  count          = "${var.three_tier ? aws_subnet.data.count : 0}"
  subnet_id      = "${element(aws_subnet.data.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}
