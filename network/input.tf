variable "name" {
  type        = "string"
  description = "The name of the stack for the VPC will be associated"
}

variable "vpc_id" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "public_cidrs" {
  type = "list"
}

variable "app_cidrs" {
  type = "list"
}

variable "data_cidrs" {
  type = "list"
}
