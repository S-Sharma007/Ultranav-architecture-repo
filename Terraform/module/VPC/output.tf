output "vpc_id" {
  description = "VPC ID"
  value      = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value      = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value      = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value      = aws_subnet.private[*].id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value      = aws_nat_gateway.main.id
}   

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value      = aws_internet_gateway.main.id
}

output "vpc_name" {
  description = "VPC Name"
  value      = aws_vpc.main.tags["Name"]
}

output "vpc_tags" {
  description = "VPC Tags"
  value      = aws_vpc.main.tags
}

output "vpc_dns_support" {
  description = "DNS Support"
  value      = aws_vpc.main.enable_dns_support
}

output "vpc_dns_hostnames" {
  description = "DNS Hostnames"
  value      = aws_vpc.main.enable_dns_hostnames
}

