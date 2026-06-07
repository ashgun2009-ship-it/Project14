resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = { Name = var.vpc_name }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = true
  tags                    = { Name = var.subnet1_name }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = true
  tags                    = { Name = var.subnet2_name }
}

resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet3_cidr
  availability_zone       = var.az3
  map_public_ip_on_launch = true
  tags                    = { Name = var.subnet3_name }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = var.igw_name }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = { Name = var.rt_name }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.public.id
}
