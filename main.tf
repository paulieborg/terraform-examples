provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "${var.state_bucket}"
    key = "${var.environment}/terraform.tfstate"
    region = "${var.region}"
    encrypt = "true"
    kms_key_id = "alias/terraform_state"
  }
}
