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
  Follow the [Terraform Install Guide](https://developer.hashicorp.com/terraform/downloads) to set up Terraform.
- IAM user with `EC2`, `S3`, `CloudFormation`, and `Budgets` permissions

### Steps

#### Terraform 

Initialize and apply Terraform:

terraform init
terraform plan
terraform apply

2. AWS Billing Cost Allocation Tags
Navigate to: AWS Billing → Cost Allocation Tags

Activate the following tags:

Owner

CostCenter

Environment

3. Budget Alert (via CloudFormation)
Before provisioning with Terraform, deploy a budget alert using CloudFormation to monitor AWS spend.

📄 budget.yaml
yaml

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
                Address: insert-your-email@example.com
Deploy Budget Stack
bash
Copy
Edit
aws cloudformation deploy \
  --template-file budget.yaml \
  --stack-name finops-budget-stack \
  --capabilities CAPABILITY_NAMED_IAM

4. Cleanup
Terraform

terraform destroy
CloudFormation

aws cloudformation delete-stack --stack-name finops-budget-stack
What You’ll Learn
How to apply FinOps tagging strategies
How to track AWS cost per resource using Cost Explorer
Reusable IaC modularization using Terraform
Use of CloudFormation for financial guardrails
Hands-on cost monitoring and cleanup practices

---

### `budget.yaml` — Copy This File Separately

```yaml
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
                Address: insert-your-email@example.com


Author
Vimbai Muyengwa
MISM ’25 @ Carnegie Mellon | FinOps | Cloud Strategy
