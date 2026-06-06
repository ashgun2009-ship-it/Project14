resource "aws_security_group" "ssh" {
  name        = "cmtr-o3e0v1ec-ssh-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range # Тут створюється 2 правила з нашого tfvars
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "cmtr-o3e0v1ec-ssh-sg" }
}

resource "aws_security_group" "public_http" {
  name        = "cmtr-o3e0v1ec-public-http-sg"
  description = "Allow HTTP inbound traffic from allowed IPs"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range # Має бути СТРОГО тільки ця змінна (дасть 2 правила)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "cmtr-o3e0v1ec-public-http-sg" }
}

resource "aws_security_group" "private_http" {
  name        = "cmtr-o3e0v1ec-private-http-sg"
  description = "Allow HTTP traffic only from Public HTTP SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_http.id] # Доступ тільки для іншої SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "cmtr-o3e0v1ec-private-http-sg" }
}