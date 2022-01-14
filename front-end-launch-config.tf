resource "aws_security_group" "front-end" {
    name = "${var.environment}-front-end-sg"
    description = " security group for database instance"
    vpc_id      = aws_vpc.demo.id

    ingress {
        from_port = 5000
        protocol  = "TCP"
        to_port   = 5000
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        protocol  = "TCP"
        to_port   = 22
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        protocol  = "-1"
        to_port   = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {    
    Name    = "${var.environment}-front-end-sg"   
  }
  
}

resource "aws_launch_configuration" "front_end" {
  
  name        = "${var.environment}-front-end-launch-config"
  

  ebs_optimized        = false
  image_id             = var.ami_id
  instance_type        = var.instance-type
  key_name             = aws_key_pair.devops.key_name
  user_data             = "${file("./scripts/front-end.sh")}"
  #user_data_base64     = var.user_data_base64

  security_groups             = ["${aws_security_group.front-end.id}"]
  associate_public_ip_address = true

   root_block_device  {
    volume_type = "gp2"
    volume_size = 40
    delete_on_termination = true
    
  }

  
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "front_end" {
  name                      = "${var.environment}-front-end-asg"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  force_delete              = false
  launch_configuration      = aws_launch_configuration.front_end.name
  vpc_zone_identifier       = [aws_subnet.public0.id]
  
  target_group_arns         = [aws_lb_target_group.target_group.arn]

  tag {
    key                 = "Name"
    value               = "front-end"
    propagate_at_launch = true
  }

}
