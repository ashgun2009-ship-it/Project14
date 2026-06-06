variable "vpc_id" { type = string }
variable "ssh_sg_name" { type = string }
variable "public_http_sg_name" { type = string }
variable "private_http_sg_name" { type = string }
variable "allowed_ip_range" { type = list(string) }