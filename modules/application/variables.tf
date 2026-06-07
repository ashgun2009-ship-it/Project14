variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "ssh_sg_id" {
  type        = string
  description = "SSH SG ID"
}

variable "ssh_sg_name" {
  type        = string
  description = "SSH SG Name"
}

variable "public_http_sg_id" {
  type        = string
  description = "Public HTTP SG ID"
}

variable "private_http_sg_id" {
  type        = string
  description = "Private HTTP SG ID"
}

variable "private_http_sg_name" {
  type        = string
  description = "Private HTTP SG Name"
}

variable "launch_template_name" {
  type        = string
  description = "Launch Template Name"
}

variable "asg_name" {
  type        = string
  description = "ASG Name"
}

variable "load_balancer_name" {
  type        = string
  description = "ALB Name"
}
