# variables.tf
variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "dynamodb_table" {
  description = "Dynamodb table name"
  type        = string
}

variable "sqs_queue" {
  description = "Sqs queue name"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}