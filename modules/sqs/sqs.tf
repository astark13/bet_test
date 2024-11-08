# modules/sqs/main.tf
resource "aws_sqs_queue" "main" {
  name                        = "${var.env_name}-queue"
  message_retention_seconds   = 1209600  # 14 days
  max_message_size            = 262144
  delay_seconds               = 0
  receive_wait_time_seconds   = 20
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount     = 5
  })
  tags = var.tags
}

resource "aws_sqs_queue" "dead_letter_queue" {
  name = "${var.env_name}-dlq"
  tags = var.tags
}

output "queue_arn" {
  value = aws_sqs_queue.main.arn
}