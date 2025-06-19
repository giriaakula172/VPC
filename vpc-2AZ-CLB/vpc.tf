#VPC:
resource "aws_vpc" "devops_vpc" {
  cidr_block = "10.0.0.0/16" #cidr_block = var.vpc_cidr
  tags = {
    Name = "Devops-VPC"
  }
}

#Internet Gateway:
resource "aws_internet_gateway" "devops_igw" {
  vpc_id = aws_vpc.devops_vpc.id
  tags = {
    Name = "Devops-IGW"
  }
}

#Public Subnet in AZ:
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.devops_vpc.id
  availability_zone       = "ap-south-1a" #availability_zone = var.azs-1
  cidr_block              = "10.0.0.0/27" #cidr_block = var.public_subnet_1a_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-1a"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.devops_vpc.id
  availability_zone       = "ap-south-1b"  #availability_zone = var.azs-2
  cidr_block              = "10.0.0.32/27" #cidr_block = var.public_subnet_1b_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-1b"
  }
}

#Public Route Table:
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.devops_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_igw.id
  }
  tags = {
    Name = "Public-RT"
  }
}
resource "aws_route_table_association" "public_subnet_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_subnet_1b" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_rt.id
}

#NAT Gateway:
resource "aws_eip" "eip-a" {

}

resource "aws_nat_gateway" "nat_gateway_1a" {
  subnet_id     = aws_subnet.public_subnet_1a.id
  allocation_id = aws_eip.eip-a.id
  tags = {
    Name = "Nat-Gateway-1a"
  }
}

resource "aws_eip" "eip-b" {

}
resource "aws_nat_gateway" "nat_gateway_1b" {
  subnet_id     = aws_subnet.public_subnet_1b.id
  allocation_id = aws_eip.eip-b.id
  tags = {
    Name = "Nat-Gateway-1b"
  }
}

#Private Subnet:
resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.devops_vpc.id
  availability_zone = "ap-south-1a"  #availability_zone = var.azs-1
  cidr_block        = "10.0.0.64/27" #cidr_block = var.private_subnet_1a_cidr
  tags = {
    Name = "Private-Subnet-1a"
  }
}
resource "aws_subnet" "private_subnet_1b" {
  vpc_id            = aws_vpc.devops_vpc.id
  availability_zone = "ap-south-1b"  #availability_zone = var.azs-2
  cidr_block        = "10.0.0.96/27" #cidr_block = var.private_subnet_1b_cidr
  tags = {
    Name = "Private-Subnet-1b"
  }
}

#Private Route Table:
resource "aws_route_table" "private_rt_1a" {
  vpc_id = aws_vpc.devops_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1a.id
  }
  tags = {
    Name = "Private-RT-1a"
  }
}
resource "aws_route_table_association" "private_rt_1a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_rt_1a.id
}

resource "aws_route_table" "private_rt_1b" {
  vpc_id = aws_vpc.devops_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1b.id
  }
  tags = {
    Name = "Private-RT-1b"
  }
}

resource "aws_route_table_association" "private_rt_1b" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.private_rt_1b.id
}
