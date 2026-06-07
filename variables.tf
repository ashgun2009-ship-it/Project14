variable "prefix" {
  type        = string
  description = "Resource name prefix provided by the platform"
}

variable "vpc_name" {
  type        = string
  description = "The exact name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "subnet1_name" {
  type        = string
  description = "Name for public subnet A"
}

variable "subnet1_cidr" {
  type        = string
  description = "CIDR block for public subnet A"
}

variable "az1" {
  type        = string
  description = "Availability zone for subnet A"
}

variable "subnet2_name" {
  type        = string
  description = "Name for public subnet B"
}

variable "subnet2_cidr" {
  type        = string
  description = "CIDR block for public subnet B"
}

variable "az2" {
  type        = string
  description = "Availability zone for subnet B"
}

variable "subnet3_name" {
  type        = string
  description = "Name for public subnet C"
}

variable "subnet3_cidr" {
  type        = string
  description = "CIDR block for public subnet C"
}

variable "az3" {
  type        = string
  description = "Availability zone for subnet C"
}

variable "igw_name" {
  type        = string
  description = "Name for the Internet Gateway"
}

variable "rt_name" {
  type        = string
  description = "Name for the Route Table"
}

variable "ssh_sg_name" {
  type        = string
  description = "Name for the SSH Security Group"
}

variable "public_http_sg_name" {
  type        = string
  description = "Name for the Public HTTP Security Group"
}

variable "private_http_sg_name" {
  type        = string
  description = "Name for the Private HTTP Security Group"
}

variable "allowed_ip_range" {
  type        = list(string)
  description = "List of allowed IP addresses for security groups"
}

variable "launch_template_name" {
  type        = string
  description = "Name for the EC2 Launch Template"
}

variable "asg_name" {
  type        = string
  description = "Name for the Auto Scaling Group"
}

variable "load_balancer_name" {
  type        = string
  description = "Name for the Application Load Balancer"
}
