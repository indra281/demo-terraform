output "vpcid" {
  value = aws_vpc.demo.id
}

output "subnet_public0" {
  value = aws_subnet.public0.id
}

output "subnet_public1" {
  value = aws_subnet.public1.id
}

output "subnet_private0" {
  value = aws_subnet.private0.id
}

output "subnet_private1" {
  value = aws_subnet.private1.id
}

output "load-balancer-dns" {
  value = aws_alb.alb.dns_name
}