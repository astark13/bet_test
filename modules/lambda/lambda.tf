# modules/lambda/main.tf
# resource "aws_iam_role" "lambda_role" {
#   name               = "${var.env_name}-lambda-role"
#   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
#   tags               = var.tags
# }

# resource "aws_iam_policy" "lambda_policy" {
#   name   = "${var.env_name}-lambda-policy"
#   policy = data.aws_iam_policy_document.lambda_policy.json
#   tags   = var.tags
# }

resource "aws_iam_role" "lambda_role" {
  name = "test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "xray:PutTraceSegments",
        "xray:PutTelemetryRecords"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "main" {
  function_name = "${var.env_name}-lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  source_code_hash = filebase64sha256("lambda.zip")
  filename         = "lambda.zip"  # Assuming the ZIP file exists

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table
    }
  }

  tracing_config {
    mode = "Active"  # Enable X-Ray
  }

  tags = var.tags
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn  = var.sqs_queue
  function_name     = aws_lambda_function.main.arn
  batch_size        = 10
  enabled           = true
}
