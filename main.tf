# Create VPC using AWS Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name       = "MyVPC"
  cidr       = var.vpc_cidr
  azs        = ["${var.aws_region}a"]
  public_subnets = [var.subnet_cidr]

  enable_dns_hostnames = true
  enable_dns_support   = true
}

# Create Security Group using AWS Module
# Create Security Group using AWS Module
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.0.0"

  name        = "allow-ssh-http"
  description = "Allow SSH and HTTP access"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH"
      cidr_blocks = "0.0.0.0/0"   # ❌ Remove brackets []
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP"
      cidr_blocks = "0.0.0.0/0"   # ❌ Remove brackets []
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"   # ❌ Remove brackets []
    }
  ]
}

# Deploy EC2 Instance using AWS Module
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.0.0"

  name           = "Pari-Server"
  instance_type  = var.instance_type
  ami           = "ami-09e143e99e8fa74f9"
  key_name       = var.key_name
  subnet_id      = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.security_group.security_group_id]

  tags = {
    Environment = "dev"
  }
}
