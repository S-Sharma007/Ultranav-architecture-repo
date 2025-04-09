provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_flow_log" "main" {
  vpc_id               = aws_vpc.main.id
  traffic_type         = "ALL"
  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.main.arn
  log_format           = "${var.log_format}"
  iam_role_arn         = "arn:aws:iam::${var.account_id}:role/${aws_iam_role.main.name}"

  tags = {
    Name = "${var.name}-flow-log"
  }
}

resource "aws_subent" "private" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.name}-private-${count.index}"
  }
  
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-${count.index}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.name}-rt"
  }
}

resource "aws_subnet_route_table_association" "public" {
  count = length(var.public_subnets)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "${var.name}-rt"
  }
}

resource "aws_subnet_route_table_association" "private" {
  count = length(var.private_subnet)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "${var.name}-nat-gateway"
  }
}

resource "aws_eip" "main" {
  vpc = true

  tags = {
    Name = "${var.name}-eip"
  }
}

resource "aws_eip_association" "main" {
  instance_id = aws_nat_gateway.main.id
  allocation_id = aws_eip.main.id
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-sg"
  }
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id


  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

