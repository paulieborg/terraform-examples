variable "region" {
  type    = "string"
  default = "ap-southeast-2"
}

variable "vpc_cidr" {
  type    = "string"
  default = "192.168.0.0/16"
}

variable "service" {
  type = "string"
}

variable "azs" {
  type = "list"

  default = [
    "ap-southeast-2a",
    "ap-southeast-2b",
    "ap-southeast-2c",
  ]
}

variable "subnet_start" {
  type        = "string"
  default     = "1"
  description = "The CIDR subnet number to start counting at. For each AZ the number is incremented by 1 from this number."
}

variable "flow_log_retention" {
  default = "60"
}

variable "flow_log_traffic_type" {
  default = "ALL"
}

variable "log_forwarder_port" {
  default = 9997 #Splunk
}

variable "db_port" {
  default = 1433
}

variable "three_tier" {
  default = true
}
