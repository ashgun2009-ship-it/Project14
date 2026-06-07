resource "aws_security_group" "ssh" {
  name        = var.ssh_sg_name
  description = "Allow SSH access"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.allowed_ip_ranges
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ssh_sg_name
  }
}

resource "aws_security_group" "public_http" {
  name        = var.public_http_sg_name
  description = "Allow public HTTP access"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.allowed_ip_ranges
    content {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.public_http_sg_name
  }
}

resource "aws_security_group" "private_http" {
  name        = var.private_http_sg_name
  description = "Allow HTTP from public ALB SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_http.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.private_http_sg_name
  }
}
