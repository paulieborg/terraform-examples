output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "internet_gateway_id" {
  value = "${aws_internet_gateway.main.id}"
}

output "app_subnet_ids" {
  value = ["${aws_subnet.app.*.id}"]
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "data_subnet_ids" {
  value = ["${aws_subnet.data.*.id}"]
}
