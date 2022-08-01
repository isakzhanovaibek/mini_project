provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "first-project-by-iat"
    key    = "dev/network/terrraform.tfstate"
    region = "eu-central-1"
  }
}

resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block_iat
  tags = {
    Name = "dev_vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "dev_igw"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "eu-central-1a"
  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "eu-central-1a"
  tags = {
    Name = "private"
  }
}
