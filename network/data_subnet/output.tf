output "subnet_ids" {
  value = ["${aws_subnet.data.*.id}"]
}
