variable "environment" {
    default = "demo" 
}

variable "region" {
    default = "us-east-1" 
}

variable "vpc_cidr" {
    default = "10.15.0.0/16"
}

variable "public0_subnet_cidr" {
    default = "10.15.74.0/24"
}

variable "public1_subnet_cidr" {
    default = "10.15.72.0/24"
}

variable "private0_subnet_cidr" {
    default = "10.15.82.0/24"
}

variable "private1_subnet_cidr" {
    default = "10.15.58.0/24"
}

variable "ami_id" {
    default = "ami-0e472ba40eb589f49"
}

variable "instance-type" {
    default = "t2.micro"
}