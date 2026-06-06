variable "aws_region" {
  type        = string
  description = "AWS region for resource deployment"
}

variable "vpc_name" {
  type        = string
  description = "Name for the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
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

variable "internet_gateway" {
  type        = string
  description = "Name for the Internet Gateway"
}

variable "routing_table" {
  type        = string
  description = "Name for the Route Table"
}

variable "ssh_security_group_name" {
  type        = string
  description = "Name for the SSH security group"
}

variable "public_http_security_group_name" {
  type        = string
  description = "Name for the Public HTTP security group"
}

variable "private_http_security_group_name" {
  type        = string
  description = "Name for the Private HTTP security group"
}

variable "allowed_ip_range" {
  type        = list(string)
  description = "List of allowed IP ranges for security groups"
}

variable "aws_launch_template_name" {
  type        = string
  description = "Name for the Launch Template"
}

variable "aws_asg_name" {
  type        = string
  description = "Name for the Auto Scaling Group"
}

variable "load_balancer" {
  type        = string
  description = "Name for the Application Load Balancer"
}