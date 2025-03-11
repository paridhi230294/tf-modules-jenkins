output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "Public Subnet ID"
  value       = module.vpc.public_subnets[0]
}

output "security_group_id" {
  description = "Security Group ID"
  value       = module.security_group.security_group_id
}

output "instance_public_ip" {
  description = "EC2 Instance Public IP"
  value       = module.ec2_instance.public_ip
}
