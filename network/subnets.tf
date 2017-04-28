data "aws_vpc" "available" {
  id = "${var.vpc_id}"
}

module "app_nat" {
  source             = "./nat"
  name               = "${var.name}"
  subnet_ids         = "${module.app_subnet.subnet_ids}"
  availability_zones = "${var.availability_zones}"
}

module "public_subnet" {
  source             = "./public_subnet"
  name               = "${var.name}"
  vpc_id             = "${var.vpc_id}"
  cidrs              = "${var.public_cidrs}"
  availability_zones = "${var.availability_zones}"
}

module "app_subnet" {
  source             = "./private_subnet"
  name               = "${var.name}"
  vpc_id             = "${var.vpc_id}"
  cidrs              = "${var.app_cidrs}"
  nat_gateway_ids    = "${module.app_nat.nat_gateway_ids}"
  availability_zones = "${var.availability_zones}"
}

module "data_subnet" {
  source             = "./data_subnet"
  name               = "${var.name}"
  vpc_id             = "${var.vpc_id}"
  cidrs              = "${var.data_cidrs}"
  availability_zones = "${var.availability_zones}"
}
