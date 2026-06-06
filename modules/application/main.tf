resource "aws_lb" "alb" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_http_sg_id]
  subnets            = var.subnet_ids
  tags               = { Name = var.load_balancer_name }
  idle_timeout       = 5
}

resource "aws_lb_target_group" "tg" {
  name                          = "${var.load_balancer_name}-tg"
  port                          = 80
  protocol                      = "HTTP"
  vpc_id                        = var.vpc_id
  target_type                   = "instance"
  load_balancing_algorithm_type = "round_robin"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_launch_template" "app" {
  name          = var.launch_template_name
  image_id      = "ami-03fd334507439f4d1"
  instance_type = "t3.micro"

  network_interfaces {
    delete_on_termination       = true
    security_groups             = [var.ssh_sg_id, var.private_http_sg_id]
    associate_public_ip_address = true
  }

  user_data = base64encode(<<-EOF
#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s2>/dev/tty) 2>&1

sleep 15

if command -v apt-get &> /dev/null; then
  apt-get update -y
  apt-get install -y apache2 curl
  systemctl start apache2
  systemctl enable apache2
elif command -v yum &> /dev/null; then
  yum update -y
  yum install -y httpd curl
  systemctl start httpd
  systemctl enable httpd
fi

WEB_DIR="/var/www/html"
mkdir -p $$WEB_DIR

SYS_UUID=$$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')
TOKEN=$$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
COMPUTE_INSTANCE_ID=$$(curl -H "X-aws-ec2-metadata-token: $$TOKEN" http://169.254.169.254/latest/meta-data/instance-id)

COMPUTE_MACHINE_UUID="$${SYS_UUID}-$$COMPUTE_INSTANCE_ID"

echo "<h1>Launch template ${var.launch_template_name}</h1>" > $$WEB_DIR/index.html
echo "<p>Instance type: t3.micro</p>" >> $$WEB_DIR/index.html
echo "<p>Security groups: ${var.ssh_sg_name} and ${var.private_http_sg_name}</p>" >> $$WEB_DIR/index.html
echo "<p>This message was generated on instance $$COMPUTE_INSTANCE_ID with the following UUID $$COMPUTE_MACHINE_UUID</p>" >> $$WEB_DIR/index.html

systemctl restart apache2 || systemctl restart httpd
EOF
  )

  tags = { Name = var.launch_template_name }
}

resource "aws_autoscaling_group" "asg" {
  name                      = var.asg_name
  vpc_zone_identifier       = var.subnet_ids
  desired_capacity          = 2
  min_size                  = 2
  max_size                  = 2
  health_check_type         = "ELB"
  health_check_grace_period = 60

  launch_template {
    id      = aws_launch_template.app.id
    version = aws_launch_template.app.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.tg.arn
}