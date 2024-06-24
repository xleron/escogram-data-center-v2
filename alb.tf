

resource "aws_lb" "main_lb" {
  name               = "escogram-alb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  enable_deletion_protection = false

  tags = {
    Name = "escogram-alb"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "alb-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "attachment_a" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.server_a.id
  port             = 80
}

# resource "aws_lb_target_group_attachment" "attachment_b" {
#   target_group_arn = aws_lb_target_group.alb_tg.arn
#   target_id        = aws_instance.server_b.id
#   port             = 80
# }
