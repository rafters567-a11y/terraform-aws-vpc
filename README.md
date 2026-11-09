# AWS VPC with Terraform

Creates a VPC with 2 public and 2 private subnets, an internet gateway and route tables.

## Usage
    terraform init
    terraform plan
    terraform apply

Outputs: `vpc_id`, `public_subnet_ids`, `private_subnet_ids`, `internet_gateway_id`, route table IDs.

Set `-var="use_localstack=true"` to target LocalStack instead of AWS.
