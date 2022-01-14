resource "aws_vpc" "demo" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
      Name = "${var.environment}-vpc"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.demo.id}"
  tags = {
      Name = "${var.environment}-internet-gateway"
  }
}

resource "aws_eip" "eip" {
  vpc  = true
  tags = {
      Name = "${var.environment}-eip"
  }

  depends_on = [aws_internet_gateway.gateway]
}

resource "aws_nat_gateway" "gateway" {
  allocation_id  = "${aws_eip.eip.id}"
  subnet_id      = "${aws_subnet.public0.id}"  
  tags = {
      Name = "${var.environment}-nat"
  }

  depends_on     = [aws_eip.eip]
}



resource "aws_subnet" "public0" {
    cidr_block  = var.public0_subnet_cidr
    vpc_id      = "${aws_vpc.demo.id}"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.environment}-public0"
    }
  
}

resource "aws_subnet" "public1" {
    cidr_block  = "${var.public1_subnet_cidr}"
    vpc_id      = "${aws_vpc.demo.id}"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.environment}-public1"
    }
  
}

resource "aws_subnet" "private0" {
    cidr_block  = "${var.private0_subnet_cidr}"
    vpc_id      = "${aws_vpc.demo.id}"

    tags = {
        Name = "${var.environment}-private0"
    }
  
}

resource "aws_subnet" "private1" {
    cidr_block  = "${var.private1_subnet_cidr}"
    vpc_id      = "${aws_vpc.demo.id}"

    tags = {
        Name = "${var.environment}-private1"
    }
  
}

resource "aws_route_table" "public_rt" {
    vpc_id = "${aws_vpc.demo.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gateway.id}"
    }
    tags = {
        Name = "${var.environment}-public-rt"
    }
  
}

resource "aws_route_table" "private_rt" {
    vpc_id = "${aws_vpc.demo.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.gateway.id}"
    }
    tags = {
        Name = "${var.environment}-private-rt"
    }
  
}

resource "aws_route_table_association" "public0-rt" {
    route_table_id  = "${aws_route_table.public_rt.id}"
    subnet_id       = "${aws_subnet.public0.id}"
}

resource "aws_route_table_association" "public1-rt" {
    route_table_id  = "${aws_route_table.public_rt.id}"
    subnet_id       = "${aws_subnet.public1.id}"
}



resource "aws_route_table_association" "private0-rt" {
    route_table_id  = "${aws_route_table.private_rt.id}"
    subnet_id       = "${aws_subnet.private0.id}"
}

resource "aws_route_table_association" "private1-rt" {
    route_table_id  = "${aws_route_table.private_rt.id}"
    subnet_id       = "${aws_subnet.private1.id}"
}