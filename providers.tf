terraform {
  required_providers {
    aws = {
      version = "= 5.33.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}
