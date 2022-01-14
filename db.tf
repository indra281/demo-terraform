resource "aws_security_group" "db" {
    name = "${var.environment}-db-sg"
    description = " security group for database instance"
    vpc_id      = aws_vpc.demo.id

    ingress {
        from_port       = 27017
        protocol        = "TCP"
        to_port         = 27017
        security_groups = [aws_security_group.front-end.id]
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
    Name    = "${var.environment}-db-sg"    
  }
  
}


resource "aws_network_interface" "db_network_interface" {
  subnet_id = aws_subnet.public1.id
  private_ips = ["10.15.72.91"]
  security_groups = [aws_security_group.db.id]
  tags ={
    Name = "db-instance-network-interface"
  }
}

resource "aws_instance" "db" {
  ami           = var.ami_id
  instance_type = var.instance-type
  key_name = aws_key_pair.devops.key_name

  network_interface {
     network_interface_id = aws_network_interface.db_network_interface.id
     device_index = 0
  }
  
  

  user_data = "${file("./scripts/mongo.sh")}"

  root_block_device  {
    volume_type = "gp2"
    volume_size = 40
    delete_on_termination = true
    tags = {
        Name = "db-ebs-volume"
      }
  }
  

  tags = {
    Name = "db-instance"
  }
}