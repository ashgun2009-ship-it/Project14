aws_region       = "eu-west-1"
vpc_name         = "cmtr-o3e0v1ec-vpc"
vpc_cidr         = "10.10.0.0/16"
subnet1_name     = "cmtr-o3e0v1ec-subnet-public-a"
subnet1_cidr     = "10.10.1.0/24"
az1              = "eu-west-1a"
subnet2_name     = "cmtr-o3e0v1ec-subnet-public-b"
subnet2_cidr     = "10.10.3.0/24"
az2              = "eu-west-1b"
subnet3_name     = "cmtr-o3e0v1ec-subnet-public-c"
subnet3_cidr     = "10.10.5.0/24"
az3              = "eu-west-1c"
internet_gateway = "cmtr-o3e0v1ec-igw"
routing_table    = "cmtr-o3e0v1ec-rt"

ssh_security_group_name          = "cmtr-o3e0v1ec-ssh-sg"
public_http_security_group_name  = "cmtr-o3e0v1ec-public-http-sg"
private_http_security_group_name = "cmtr-o3e0v1ec-private-http-sg"

allowed_ip_range = ["18.153.146.156/32", "213.109.232.0/32"]

aws_launch_template_name = "cmtr-o3e0v1ec-template"
aws_asg_name             = "cmtr-o3e0v1ec-asg"
load_balancer            = "cmtr-o3e0v1ec-lb"