variable "name" {
  default = "nat"
}

variable "availability_zones" {
  type = "list"
}

variable "subnet_ids" {
  type = "list"
}
