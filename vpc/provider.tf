provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::633017616022:role/a206399-developer"
    session_name = "a206399-developer"
}
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
