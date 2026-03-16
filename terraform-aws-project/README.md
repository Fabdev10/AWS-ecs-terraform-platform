# Terraform AWS Project

This repository is structured like a small production platform rather than a single-root tutorial. Each environment composes reusable modules, which keeps change scope narrow and makes promotion across environments easier to reason about.

## Current status

Phase 1 is implemented:

- repository scaffold
- reusable VPC module
- dev and prod root modules wired to the VPC module
- placeholder module directories for ECS, ALB, RDS, and ECR
- simple Node.js application scaffold for the later ECS phase

## Repository layout

```text
terraform-aws-project/
├── environments/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── prod/
│       ├── backend.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── terraform.tfvars
│       └── variables.tf
├── modules/
│   ├── alb/
│   ├── ecr/
│   ├── ecs/
│   ├── rds/
│   └── vpc/
├── app/
│   ├── .dockerignore
│   ├── Dockerfile
│   ├── package.json
│   └── src/
│       └── index.js
└── README.md
```

## VPC design decisions

- Two public and two private subnets are split across two availability zones in eu-west-1.
- Each AZ gets its own NAT Gateway so private workloads keep outbound traffic inside the same AZ and avoid a single-AZ egress dependency.
- Public subnets are intended for the ALB and NAT Gateways.
- Private subnets are reserved for ECS tasks and the PostgreSQL database.

## Backend prerequisites

This repository assumes the Terraform backend already exists.

Create these resources outside this stack before the first init:

- an S3 bucket for Terraform state
- a DynamoDB table for state locking

The backend blocks are intentionally partial so you can inject account-specific values at runtime instead of hard-coding them into versioned files.

Example init for dev:

```bash
cd terraform-aws-project/environments/dev
terraform init \
  -backend-config="bucket=YOUR_TF_STATE_BUCKET" \
  -backend-config="key=dev/network/terraform.tfstate" \
  -backend-config="region=eu-west-1" \
  -backend-config="dynamodb_table=YOUR_TF_LOCK_TABLE"
```

Example plan for dev:

```bash
terraform fmt -recursive ../../
terraform validate
terraform plan -var-file=terraform.tfvars
```

Repeat the same flow in environments/prod with a different backend key.

## Local application usage

The application is a minimal Express service with two endpoints:

- `/` returns a hello-world response
- `/health` returns HTTP 200 for future ALB health checks

Build and run locally:

```bash
cd terraform-aws-project/app
docker build -t hello-world-app .
docker run -p 3000:3000 hello-world-app
```

## What comes next

The next infrastructure phase should add the ALB module, because it establishes the entrypoint contract that the ECS service will depend on.

## CI/CD with GitHub Actions

This repository now includes a complete Terraform pipeline in `../.github/workflows/terraform-ci-cd.yml`.

The workflow includes:

- `terraform fmt -check -recursive`
- `terraform validate` for `dev` and `prod`
- Terraform plan for `dev` and `prod`
- automatic apply to `dev` on push to `main`
- manual apply to `prod` via `workflow_dispatch`

### Required GitHub secrets

Add these repository secrets before running the pipeline:

- `AWS_ROLE_ARN_DEV` (IAM role to assume in dev via OIDC)
- `AWS_ROLE_ARN_PROD` (IAM role to assume in prod via OIDC)
- `TF_STATE_BUCKET` (S3 bucket name used for Terraform state)
- `TF_LOCK_TABLE` (DynamoDB table name used for Terraform locking)

### Recommended GitHub environment setup

Create two GitHub Environments:

- `development`
- `production`

For `production`, configure required reviewers to enforce a manual approval gate before `apply`.

### Trigger behavior

- Pull request:
  - runs format and validation checks
  - runs plans for both `dev` and `prod`
- Push to `main`:
  - runs checks and plan
  - applies automatically to `dev`
- Manual run (`workflow_dispatch`):
  - choose environment (`dev` or `prod`)
  - choose action (`plan` or `apply`)

### Notes

- All Terraform commands run inside `environments/dev` and `environments/prod`.
- Backend config is injected at runtime (`bucket`, `key`, `region`, `dynamodb_table`).
- For pull requests from forks, plan jobs may be skipped or fail if secrets are not available.
