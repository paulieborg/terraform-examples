variable "environment" {
  default = "paul-test"
}

variable "availability_zones" {
  type = "list"
  default = [
    "ap-southeast-2b",
    "ap-southeast-2a",
    "ap-southeast-2c"
  ]
}