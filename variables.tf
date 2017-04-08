variable "region" {
  default = "ap-southeast-2"
}

variable "environment" {
  default = "dev"
}

variable "state_bucket" {
  description = "The bucket to retain terraform state"
  default = "remote_bucket_tf"
}
