# FinOpsEngineer_IAC
FinOps Infrastructure-as-Code Project 

## Objective

Build a FinOps-focused cloud environment using Infrastructure-as-Code that supports:

- Automated provisioning of EC2 and S3 resources
- Standardized cost allocation tagging
- Visibility into spend through AWS Cost Explorer and Billing
- Easy cleanup and repeatable testing

---

## Architecture

This lab includes:

- An **EC2 instance** (t2.micro) with FinOps tagging (`Owner`, `CostCenter`, `Environment`)
- An **S3 bucket** with unique naming via `random_id` and cost tags
- Modularized **Terraform** structure for reusability
- A **CloudFormation-based AWS Budget alert** with email notification

---

## Recommended Folder & File Layout

<pre><code>
finops-iac-lab/
├── modules/
│   ├── ec2/
│   │   ├── main.tf
│   │   └── variables.tf
│   └── s3/
│       ├── main.tf
│       └── variables.tf
├── main.tf
├── variables.tf
├── providers.tf
├── README.md
├── .gitignore
</code></pre>

---

## Modules

| Module | Purpose |
|--------|---------|
| `ec2`  | Deploys a lightweight EC2 instance with FinOps tags |
| `s3`   | Deploys a uniquely named S3 bucket with FinOps tags |

---

## Files Overview

| File              | Description                                 |
|-------------------|---------------------------------------------|
| `main.tf`         | Connects modules and passes variables       |
| `variables.tf`    | Defines user-customizable variables         |
| `providers.tf`    | AWS provider and region configuration       |
| `modules/ec2`     | Contains EC2 Terraform code and variables   |
| `modules/s3`      | Contains S3 Terraform code and variables    |
| `.gitignore`      | Excludes Terraform state and config files   |

---

## Getting Started

### Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform installed
- IAM user with `EC2`, `S3`, `CloudFormation`, and `Budgets` permissions

### Steps

terraform init
terraform plan
terraform apply

Then go to AWS Billing → Cost Allocation Tags, and activate:
Owner
CostCenter
Environment

AWS Budget Alert via CloudFormation
Before deploying with Terraform, this lab uses CloudFormation to create a monthly AWS budget with an email alert when usage exceeds 80% of the $10 limit.

#### CloudFormation Template: budget.yaml

AWSTemplateFormatVersion: '2010-09-09'
Description: AWS Monthly Budget Alert

Resources:
  MonthlyBudget:
    Type: "AWS::Budgets::Budget"
    Properties:
      Budget:
        BudgetName: "FinOpsMonthlyBudget"
        BudgetLimit:
          Amount: 10
          Unit: USD
        TimeUnit: MONTHLY
        BudgetType: COST
      NotificationsWithSubscribers:
        - Notification:
            NotificationType: ACTUAL
            ComparisonOperator: GREATER_THAN
            Threshold: 80
          Subscribers:
            - SubscriptionType: EMAIL
              Address: insert email 

Deployment Command:
aws cloudformation deploy \
  --template-file budget.yaml \
  --stack-name finops-budget-stack \
  --capabilities CAPABILITY_NAMED_IAM

#### Cleanup

terraform destroy
To remove the CloudFormation stack:
aws cloudformation delete-stack --stack-name finops-budget-stack

### What You Learn

How to apply FinOps tagging strategies

How to track AWS cost per resource via Cost Explorer

Reusable IaC modularization using Terraform

CloudFormation for financial guardrails

Hands-on practice managing and monitoring cloud costs


Author
Vimbai Muyengwa
MISM ’25 @ Carnegie Mellon | FinOps | Cloud Strategy<img width="786" height="38" alt="image" src="https://github.com/user-attachments/assets/731ea7af-c128-47f3-b70f-3616375f5e31" />
