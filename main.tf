module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source = "./modules/subnet"
}

module "ec2" {
  source = "./modules/ec2"
}

