variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "allowed_ip_ranges" {
  type        = list(string)
  description = "List of IPs allowed to connect"
}

variable "ssh_sg_name" {
  type        = string
  description = "Full name for the SSH security group"
}

variable "public_http_sg_name" {
  type        = string
  description = "Full name for the public HTTP security group"
}

variable "private_http_sg_name" {
  type        = string
  description = "Full name for the private HTTP security group"
}
