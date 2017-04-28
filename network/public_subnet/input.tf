variable "name" {
  type    = "string"
  default = "public"
}

variable "vpc_id" {
  type = "string"
}

variable "cidrs" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}
