resource "aws_sqs_queue" "queue" {
  name = "${var.name}-${terraform.workspace}"
  tags = {
    Name        = var.name
    Environment = terraform.workspace
  }
}
