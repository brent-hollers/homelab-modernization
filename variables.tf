variable "aws_region" {
  description = "The AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "home_public_ip" {
  description = "Public IP of the On-Premise Router (pfSense)"
  type        = string
  # No default here - forces you to define it in a tfvars file or CLI
}

variable "internal_network_cidr" {
  description = "CIDR block of the Home Lab Network"
  type        = string
  default     = "192.168.50.0/24"
}

variable "vpc_cidr" {
  description = "CIDR block for the AWS Migration VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_az" {
  description = "Availability zone(s) for VPC"
  type        = string
  default     = "us-east-1a"
}