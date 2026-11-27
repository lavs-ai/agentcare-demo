# AgentCare Cloud — Example Setup

A small, safe example of what an AgentCare Cloud setup looks like.
This is a demo, not a production system. It shows the pattern I use for clients:
an AI agent behind an API, with least-privilege access, logging, a spending
alarm, and nothing secret in the code.

## What is in here

- `app/` — a tiny Python Lambda handler. It answers with a canned reply,
  logs the request, and never calls a model with live credentials in this demo.
- `terraform/` — AWS resources: Lambda, API Gateway, CloudWatch log group,
  an AWS Budget alarm, and an IAM role with only the permissions the
  Lambda needs.
- `docs/handover.md` — what a client receives at handover.
- `.github/workflows/deploy.yml` — deploy on push to `main`.

## Architecture

```
Client -> API Gateway -> Lambda (demo agent)
                          -> CloudWatch Logs
                          -> AWS Budget alarm (email at 80% of budget)
```

No database, no public S3 bucket, no hard-coded keys. Secrets, if a real
agent needs them, go in AWS Secrets Manager — never in Git.

## How to use this demo

1. Copy this repo, do not deploy it as-is to a client account.
2. Read `docs/handover.md` first — that is the document a client keeps.
3. Change the budget amount, region, and email in `terraform/variables.tf`.
4. `terraform init && terraform plan` — check the plan before you apply.

## Cost

This demo is designed to stay inside the AWS free tier for a small test.
Set the budget alarm first, before you deploy anything else.
