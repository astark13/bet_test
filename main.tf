# main.tf
module "sqs" {
  source  = "./modules/sqs"
  env_name = var.env_name
  tags     = var.tags
}

module "dynamodb" {
  source  = "./modules/dynamodb"
  env_name = var.env_name
  tags     = var.tags
}

module "lambda" {
  source     = "./modules/lambda"
  env_name   = var.env_name
  sqs_queue  = module.sqs.queue_arn
  dynamodb_table = module.dynamodb.table_name
  tags       = var.tags
}