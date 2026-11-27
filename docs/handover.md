# Handover — Example Setup

What the client receives at the end of a setup. This is the document
a client can hand to any engineer.

## What was built
- API Gateway + Lambda demo agent
- CloudWatch Logs — 14-day retention
- AWS Budget alarm — email at 80% of the monthly budget

## What the client owns
- All code in their GitHub repo
- All resources in their AWS account
- This handover document

## Access
- AgentCare access is least-privilege and can be removed at any time.
- No shared root credentials. No secrets in Git.

## If something goes wrong
1. Check CloudWatch Logs for the Lambda function.
2. Check the budget alarm email.
3. Contact Lavanya — hello@agentcarecloud.com — reply within one business day.

## Next steps the client can choose
- Care Plan from A$300/month — monitoring, monthly cost and security report,
  backups checked, updates applied.
- Or no ongoing plan — the setup keeps working, and the client owns it.
