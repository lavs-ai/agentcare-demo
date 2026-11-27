variable "aws_region" {
  description = "AWS region for the demo"
  type        = string
  default     = "ap-southeast-2"
}

variable "monthly_budget_usd" {
  description = "Monthly budget alarm amount in USD"
  type        = string
  default     = "20"
}

variable "alert_email" {
  description = "Email for budget alerts — change this before applying"
  type        = string
  default     = "hello@agentcarecloud.com"
}
