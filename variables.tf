# variables.tf
variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket for Terraform state storage"
  type        = string
}

variable "lock_table" {
  description = "DynamoDB table for state locking"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
