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
