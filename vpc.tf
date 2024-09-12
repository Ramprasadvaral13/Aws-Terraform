resource "aws_vpc" "demo-vpc" {
    cidr_block = var.vpc-cidr
    enable_dns_hostnames = true
    enable_dns_support = true
}

resource "aws_internet_gateway" "demo-igw" {
    vpc_id = aws_vpc.demo-vpc.id
 
}

resource "aws_subnet" "demo-public-subnet" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = var.public-cidr
    availability_zone = var.Az
    map_public_ip_on_launch = true
    
}

resource "aws_subnet" "demo-private-subnet" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = var.private-cidr
    availability_zone = var.Az
  
}

resource "aws_route_table" "demo-public-route" {
    vpc_id = aws_vpc.demo-vpc.id
    route{
        gateway_id = aws_internet_gateway.demo-igw.id
        cidr_block = var.route-cidr
    }
  
}

resource "aws_route_table_association" "demo-public-rta" {
    route_table_id = aws_subnet.demo-public-subnet.id
    subnet_id = aws_subnet.demo-public-subnet.id
  
}

resource "aws_eip" "demo-eip" {
    domain = "vpc"
  
}

resource "aws_nat_gateway" "demo-nat" {
    allocation_id = aws_eip.demo-eip.id
    subnet_id = aws_subnet.demo-public-subnet.id
  
}

resource "aws_route_table" "demo-private-route" {
    vpc_id = aws_vpc.demo-vpc.id
    route {
        cidr_block = var.route-cidr
        nat_gateway_id = aws_nat_gateway.demo-nat.id
    }
  
}

resource "aws_route_table_association" "demo-private-rta" {
    subnet_id = aws_subnet.demo-private-subnet.id
    route_table_id = aws_route_table.demo-private-route.id
  
}