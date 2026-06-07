variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "subnet1_name" {
  type        = string
  description = "Subnet 1 Name"
}

variable "subnet1_cidr" {
  type        = string
  description = "Subnet 1 CIDR"
}

variable "az1" {
  type        = string
  description = "Subnet 1 AZ"
}

variable "subnet2_name" {
  type        = string
  description = "Subnet 2 Name"
}

variable "subnet2_cidr" {
  type        = string
  description = "Subnet 2 CIDR"
}

variable "az2" {
  type        = string
  description = "Subnet 2 AZ"
}

variable "subnet3_name" {
  type        = string
  description = "Subnet 3 Name"
}

variable "subnet3_cidr" {
  type        = string
  description = "Subnet 3 CIDR"
}

variable "az3" {
  type        = string
  description = "Subnet 3 AZ"
}

variable "igw_name" {
  type        = string
  description = "IGW Name"
}

variable "rt_name" {
  type        = string
  description = "Route Table Name"
}
