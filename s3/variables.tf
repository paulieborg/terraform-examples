variable "region" {
  type    = "string"
  default = "ap-southeast-2"
}

variable "account_name" {
  type        = "string"
  description = "The logical account name in form of division-capability-environment (ie ex-coreservices-development)"
  default = "ex-essentials-nonprod-admin"
}
