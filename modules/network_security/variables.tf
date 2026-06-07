variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "allowed_ip_range" {
  type        = list(string)
  description = "Allowed IPs"
}

variable "ssh_sg_name" {
  type        = string
  description = "SSH SG Name"
}

variable "public_http_sg_name" {
  type        = string
  description = "Public HTTP SG Name"
}

variable "private_http_sg_name" {
  type        = string
  description = "Private HTTP SG Name"
}
