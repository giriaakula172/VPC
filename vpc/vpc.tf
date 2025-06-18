#VPC
resource "aws_vpc" "devops_vpc" {
  cidr_block = "10.0.0.0/16" #cidr_block = var.vpc_cidr
  tags = {
    Name = "Devops-VPC"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "devops_igw" {
  vpc_id = aws_vpc.devops_vpc.id
  tags = {
    Name = "Devops-IGW"
  }
}

#Public Subnet in AZ
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.devops_vpc.id
  availability_zone       = "ap-south-1a" #availability_zone = var.azs
  cidr_block              = "10.0.0.0/27" #cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet"
  }
}

#Public Route Table
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
resource "aws_route_table_association" "public_rt" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

#NAT Gateway
resource "aws_eip" "eip" {

}

resource "aws_nat_gateway" "nat_gateway" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.eip.id
  tags = {
    Name = "Nat-Gateway"
  }
}

#Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.devops_vpc.id
  availability_zone = "ap-south-1a"  #availability_zone = var.azs
  cidr_block        = "10.0.0.32/27" #cidr_block = var.	private_subnet_cidr.id
  tags = {
    Name = "Private-Subnet"
  }
}

#Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.devops_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "Private-RT"
  }
}

resource "aws_route_table_association" "private_rt" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}
