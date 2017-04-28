terraform {
  required_version = ">= 0.9.1"

  backend "s3" {
    bucket     = "myob-dont-panic-test"
    key        = "service-1/terraform.tfstate"
    region     = "ap-southeast-2"
    encrypt    = "true"
    kms_key_id = "alias/terraform-kms"
  }
}

provider "aws" {
  region = "${var.region}"
}
