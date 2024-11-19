resource "aws_lb" "load_balancer" {
  name               = "lb-webservers"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_webserver]
  subnets            = [var.public_subnet_1, var.public_subnet_2]
}

resource "aws_lb_target_group" "webserver_group" {
    name = "webserver-instances-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
      path = "/health"
      port = 80
      protocol = "HTTP"
    }
}

resource "aws_lb_target_group_attachment" "attachment_wb1" {
    target_group_arn = aws_lb_target_group.webserver_group.arn
    target_id = aws_instance.web_server_1.id
    port = 80
}

resource "aws_lb_target_group_attachment" "attachment_wb2" {
    target_group_arn = aws_lb_target_group.webserver_group.arn
    target_id = aws_instance.web_server_2.id
    port = 80
}

resource "aws_lb_listener" "listener_lb" {
    load_balancer_arn = aws_lb.load_balancer.arn
    port = 80
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.webserver_group.arn
    }
}


// ======================
resource "aws_lb" "load_balancer_dash" {
  name               = "lb-dash"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_webserver]
  subnets            = [var.public_subnet_1, var.public_subnet_2]
}

resource "aws_lb_target_group" "dashboard_group" {
    name = "dashboard-instances-tg"
    port = 443
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
      path = "/health"
      port = 443
      protocol = "HTTP"
    }
}

resource "aws_lb_target_group_attachment" "attachment_dash1" {
    target_group_arn = aws_lb_target_group.dashboard_group.arn
    target_id = aws_instance.dashboard_1.id
    port = 443
}

resource "aws_lb_target_group_attachment" "attachment_dash2" {
    target_group_arn = aws_lb_target_group.dashboard_group.arn
    target_id = aws_instance.dashboard_2.id
    port = 443
}

resource "aws_lb_listener" "listener_lb_dash" {
    load_balancer_arn = aws_lb.load_balancer_dash.arn
    port = 443
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.dashboard_group.arn
    }
}