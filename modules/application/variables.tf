variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where application resources will be deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the Application Load Balancer and Auto Scaling Group"
}

variable "ssh_sg_id" {
  type        = string
  description = "The ID of the SSH Security Group"
}

variable "ssh_sg_name" {
  type        = string
  description = "The full name of the SSH Security Group used for verification on the web page"
}

variable "public_http_sg_id" {
  type        = string
  description = "The ID of the Public HTTP Security Group applied to the ALB"
}

variable "private_http_sg_id" {
  type        = string
  description = "The ID of the Private HTTP Security Group applied to the instances"
}

variable "private_http_sg_name" {
  type        = string
  description = "The full name of the Private HTTP Security Group used for verification on the web page"
}

variable "launch_template_name" {
  type        = string
  description = "The dynamically generated name for the AWS Launch Template"
}

variable "asg_name" {
  type        = string
  description = "The dynamically generated name for the Auto Scaling Group"
}

variable "load_balancer_name" {
  type        = string
  description = "The dynamically generated name for the Application Load Balancer"
}
