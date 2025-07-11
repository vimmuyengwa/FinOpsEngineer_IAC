provider "aws" {
  region = "us-east-1"
}

# EC2 Instance
resource "aws_instance" "finops_ec2" {
  ami           = "ami-000ec6c25978d5999" # Amazon Linux 2 AMI
  instance_type = "t2.micro"

  tags = {
    Name         = "FinOpsEC2"
    Owner        = "vimbai"
    Environment  = "dev"
    CostCenter   = "finops"
  }
}

# Random ID for unique S3 bucket name
resource "random_id" "id" {
  byte_length = 4
}

# S3 Bucket with cost allocation tags
resource "aws_s3_bucket" "finops_sandbox" {
  bucket = "finops-bucket-${random_id.id.hex}"

  tags = {
    Name         = "FinOpsS3"
    Owner        = "vimbai"
    Environment  = "dev"
    CostCenter   = "finops"
  }
}
