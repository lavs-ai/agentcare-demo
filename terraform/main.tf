terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Least-privilege role: the Lambda can only write its own logs.
resource "aws_iam_role" "agent" {
  name = "agentcare-demo-agent"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "logs" {
  role       = aws_iam_role.agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "agent" {
  function_name = "agentcare-demo-agent"
  role          = aws_iam_role.agent.arn
  handler       = "handler.handler"
  runtime       = "python3.12"
  filename      = "../app.zip"
}

resource "aws_apigatewayv2_api" "api" {
  name          = "agentcare-demo-api"
  protocol_type = "HTTP"
}

# Spending control: email alert at 80% of the monthly budget.
resource "aws_budgets_budget" "monthly" {
  name         = "agentcare-demo-monthly"
  budget_type  = "COST"
  limit_amount = var.monthly_budget_usd
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.alert_email]
  }
}
