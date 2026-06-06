terraform {
  required_version = ">= 1.5.7"
}

module "network" {
  source = "./modules/network"

  vpc_name     = var.vpc_name
  vpc_cidr     = var.vpc_cidr
  subnet1_name = var.subnet1_name
  subnet1_cidr = var.subnet1_cidr
  az1          = var.az1
  subnet2_name = var.subnet2_name
  subnet2_cidr = var.subnet2_cidr
  az2          = var.az2
  subnet3_name = var.subnet3_name
  subnet3_cidr = var.subnet3_cidr
  az3          = var.az3
  igw_name     = var.internet_gateway
  rt_name      = var.routing_table
}

module "network_security" {
  source = "./modules/network_security"

  vpc_id               = module.network.vpc_id
  ssh_sg_name          = var.ssh_security_group_name
  public_http_sg_name  = var.public_http_security_group_name
  private_http_sg_name = var.private_http_security_group_name
  allowed_ip_range     = var.allowed_ip_range
}

module "application" {
  source = "./modules/application"

  vpc_id               = module.network.vpc_id
  subnet_ids           = module.network.subnet_ids
  ssh_sg_id            = module.network_security.ssh_sg_id
  ssh_sg_name          = var.ssh_security_group_name
  public_http_sg_id    = module.network_security.public_http_sg_id
  private_http_sg_id   = module.network_security.private_http_sg_id
  private_http_sg_name = var.private_http_security_group_name
  launch_template_name = var.aws_launch_template_name
  asg_name             = var.aws_asg_name
  load_balancer_name   = var.load_balancer
}