resource "aws_lb" "alb" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_http_sg_id]
  subnets            = var.subnet_ids
  idle_timeout       = 5

  tags = {
    Name = var.load_balancer_name
  }
}

resource "aws_lb_target_group" "tg" {
  name                          = "${var.load_balancer_name}-tg"
  port                          = 80
  protocol                      = "HTTP"
  vpc_id                        = var.vpc_id
  target_type                   = "instance"
  load_balancing_algorithm_type = "round_robin"

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
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
    associate_public_ip_address = true
    delete_on_termination       = true

    security_groups = [
      var.ssh_sg_id,
      var.private_http_sg_id
    ]
  }

  user_data = base64encode(<<-EOF
#!/bin/bash

sleep 15

if command -v apt-get >/dev/null 2>&1; then
  apt-get update -y
  apt-get install -y apache2 curl
  systemctl enable apache2
  systemctl start apache2
elif command -v yum >/dev/null 2>&1; then
  yum update -y
  yum install -y httpd curl
  systemctl enable httpd
  systemctl start httpd
fi

COMPUTE_MACHINE_UUID=$$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')

TOKEN=$$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

COMPUTE_INSTANCE_ID=$$(curl -s \
-H "X-aws-ec2-metadata-token: $${TOKEN}" \
http://169.254.169.254/latest/meta-data/instance-id)

cat > /var/www/html/index.html <<HTML
This message was generated on instance $${COMPUTE_INSTANCE_ID} with the following UUID $${COMPUTE_MACHINE_UUID}
HTML

systemctl restart apache2 || systemctl restart httpd
EOF
  )

  tags = {
    Name = var.launch_template_name
  }
}

resource "aws_autoscaling_group" "asg" {
  name                = var.asg_name
  vpc_zone_identifier = var.subnet_ids

  min_size         = 2
  max_size         = 2
  desired_capacity = 2

  health_check_type         = "ELB"
  health_check_grace_period = 120

  target_group_arns = [
    aws_lb_target_group.tg.arn
  ]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.asg_name
    propagate_at_launch = true
  }
}