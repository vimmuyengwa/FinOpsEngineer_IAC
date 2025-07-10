# FinOpsEngineer_IAC
FinOps Infrastructure-as-Code Project 

Recommended Folder & File Layout
css
Copy
Edit
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
🧾 README.md (Summary of Work)
Here’s an outline you can use for your README.md:

# FinOps Infrastructure as Code Lab
This project is a modular, reusable Terraform lab to demonstrate FinOps principles through automated AWS resource provisioning with cost governance in mind.

## Objective
Build a FinOps-focused cloud environment using Infrastructure-as-Code that supports:

Automated provisioning of EC2 and S3 resources

Standardized cost allocation tagging

Visibility into spend through AWS Cost Explorer and Billing

Easy cleanup and repeatable testing

## Architecture
This lab deploys:

An EC2 instance (t2.micro) with FinOps tagging (Owner, CostCenter, Environment)
An S3 bucket with unique naming and lifecycle tagging
Modularized Terraform structure for reuse and scale
Optional integration with AWS Cost Explorer and Budgets

## Modules
Module	Purpose
ec2	Deploys a lightweight EC2 instance with FinOps tags
s3	Deploys a uniquely named S3 bucket with FinOps tags

## 📂 Files Overview
File	Description
main.tf	Connects modules and passes variables
variables.tf	Defines user-customizable variables
providers.tf	AWS provider and region config
modules/ec2	EC2 module with tagging
modules/s3	S3 module with random name + tagging

## Getting Started
Prerequisites
AWS CLI configured (aws configure)

Terraform installed

IAM user with EC2/S3/CloudFormation/Budgets permissions

Steps
bash
Copy
Edit
terraform init
terraform plan
terraform apply
Activate cost allocation tags in AWS Billing

## Cleanup
bash
Copy
Edit
terraform destroy

## What You Learn
How to apply FinOps tagging strategies

How to track AWS cost per resource via Cost Explorer

Reusable IaC modularization using Terraform

Hands-on practice managing and monitoring cloud costs

## Next Steps (Optional Enhancements)
Add Terraform budget alert module

Integrate S3 lifecycle rules

Set up Cost and Usage Reports (CUR)

Use AWS Config or SCPs for tag enforcement

## Author
Vimbai Muyengwa
MISM ’25 @ Carnegie Mellon | FinOps | Cloud Strategy | Technical Program Management
