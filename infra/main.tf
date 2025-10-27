##############################################
# File: infra/main.tf
# Purpose: connect Terraform to AWS
##############################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "cloudops-terraform-state-425221470048"
    key            = "infra/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region  = "ca-central-1"
  profile = "default"
}
