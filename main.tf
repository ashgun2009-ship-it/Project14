module "network_security" {
  source               = "./modules/network_security"
  vpc_id               = module.network.vpc_id
  allowed_ip_ranges    = var.allowed_ip_ranges
  ssh_sg_name          = "${var.prefix}-ssh-sg"
  public_http_sg_name  = "${var.prefix}-public-http-sg"
  private_http_sg_name = "${var.prefix}-private-http-sg"
}
