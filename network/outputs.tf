// A list of the created subnet ids.
output "public_subnet_ids" {
  value = [
    "${module.public_subnet.subnet_ids}",
  ]
}

output "app_subnet_ids" {
  value = [
    "${module.app_subnet.subnet_ids}",
  ]
}

output "data_subnet_ids" {
  value = [
    "${module.data_subnet.subnet_ids}",
  ]
}
