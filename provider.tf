# provider.tf
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "project-a-terraform.tfstate-bucket"
    key            = "bet_test_dev/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-locking"
  }
}