resource "aws_alb" "alb" {  
  name               = "${var.environment}-alb"  
  subnets            = ["${aws_subnet.public0.id}"]
  internal           = false  
  load_balancer_type = "network"

  tags = {    
    Name    = "${var.environment}-alb"    
  }   
}

resource "aws_lb_listener" "alb_listener" {
  depends_on        = [aws_lb_target_group.target_group]
  load_balancer_arn = "${aws_alb.alb.arn}"
  port                = 80
  protocol            = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
  }
}

resource "aws_lb_target_group" "target_group" {  
  name        = "${var.environment}-target-grp" 
  target_type = "instance"
  port        = "5000" 
  protocol    = "TCP"  
  vpc_id      = "${aws_vpc.demo.id}"   
  tags = {    
    Name = "${var.environment}-target-grp"    
  }   
    
  health_check {    
    healthy_threshold   = 2   
    unhealthy_threshold = 2    
    protocol            = "TCP"    
    interval            = 10    
    port                = "5000"  
  }
}

