##############################################
# File: infra/vpc.tf
# Purpose: define our base network (VPC)
##############################################

# 1. Create the VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16" # network range for all subnets
  enable_dns_hostnames = true          # allows EC2 instances to get DNS names
  enable_dns_support   = true

  tags = {
    Name = "cloudops-main-vpc"
  }
}

# 2. Output the VPC ID so we can reuse it later
output "vpc_id" {
  value = aws_vpc.main.id
}
