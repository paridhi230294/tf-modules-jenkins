variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Public Subnet CIDR Block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH Key Pair"
  type        = string
  default     = "my-key-arjun1"
}
variable "rules" {
  description = "Security group rules: from_port, to_port, protocol"
  type = map(list(string))
  default = {
    "ssh"  = [22, 22, "tcp"]
    "http" = [80, 80, "tcp"]
    "https" = [443, 443, "tcp"]
  }
}
