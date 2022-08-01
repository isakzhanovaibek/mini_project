provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "first-project-by-iat"
    key    = "dev/servers/terrraform.tfstate"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "first-project-by-iat"
    key    = "dev/network/terrraform.tfstate"
    region = "eu-central-1"
  }
}

data "aws_ami" "amazon_latest" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "main_webserver" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.amazon_latest.id
  vpc_security_group_ids = [aws_security_group.webserver.id]
  subnet_id              = data.terraform_remote_state.networking.outputs.public_subnet_iat
  tags = {
    Name = "WebServer"
  }
}


resource "aws_security_group" "webserver" {
  name   = "Webserver SG"
  vpc_id = data.terraform_remote_state.networking.outputs.vpc_id_iat


  ingress {
    description = "SSH_SG"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.networking.outputs.cidr_block_iat]
  }

  ingress {
    description = "HTTP_SG"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "webserver_sg"
    owner = "Aibek Isakzhanov"
  }
}
