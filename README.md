# FinOpsEngineer_IAC
FinOps Infrastructure-as-Code Project 

## Objective

Build a FinOps-focused cloud environment using Infrastructure-as-Code that supports:

- Set up an AWS Budget alert using CloudFormation  
- Automated provisioning of EC2 and S3 resources with terrafrom
- Standardized cost allocation tagging with terraform
- Easy cleanup and repeatable testing
- Visibility into spend through AWS Cost Explorer and Billing
- Enable automated cleanup

---

## Folder Structure

```cpp
finops-iac-lab/
├── terraform/
│   ├── main.tf)
├── cloudformation/
│   └── budget.yaml
├── README.md
└── .gitignore
```


## Prerequisits 
AWS CLI installed on Mac 

Run in terminal:

```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
```

Install the package
Run:

```bash
sudo installer -pkg AWSCLIV2.pkg -target /
```

Configure AWS CLI
Once it’s installed, run:

```bash
aws configure
```

## Architecture

This lab includes:

- An **EC2 instance** (t2.micro) with FinOps tagging (`Owner`, `CostCenter`, `Environment`)
- An **S3 bucket** with unique naming via `random_id` and cost tags
- Modularized **Terraform** structure for reusability
- A **CloudFormation-based AWS Budget alert** with email notification

# Part 1: Setup & Budgeting via CloudFormation
## Create budget.yaml CloudFormation Template
Create a file called budget.yaml with the following content:

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
              Address: your-email@example.com

```

## Deploy CloudFormation Budget

```
aws cloudformation deploy \
  --template-file budget.yaml \
  --stack-name finops-budget-stack \
  --capabilities CAPABILITY_NAMED_IAM
```

# Part 2: Terraform – Launch EC2 with Cost Tags
## Step 2.1: Create Terraform Directory

```bash
mkdir finops-terraform && cd finops-terraform

## Step 2.2: Create main.tf
```hcl

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "finops_ec2" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = "t2.micro"

  tags = {
    Name         = "FinOpsEC2"
    Owner        = "your-name"
    Environment  = "dev"
    CostCenter   = "finops"
  }
}
```

## Step 2.3: Initialize & Apply Terraform
```bash
terraform init
terraform plan
terraform apply
```

# Part 3: Cost Allocation Tag Setup (in Console)
Go to AWS Billing → Cost Allocation Tags

Find and activate tags: Owner, Environment, CostCenter

These tags will now appear in Cost Explorer and Budgets

# Part 4: Cleanup
```bash
terraform destroy
aws cloudformation delete-stack --stack-name finops-budget-stack
```


Author
Vimbai Muyengwa
MISM ’25 @ Carnegie Mellon | FinOps | Cloud Strategy


