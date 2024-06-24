resource "aws_route_table" "private_rt_a" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "private-rt-a"
  }
}

resource "aws_route_table_association" "rt_assoc_private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_rt_a.id
}

resource "aws_route" "route_private_a" {
  route_table_id         = aws_route_table.private_rt_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.public_ngw_a.id
}

resource "aws_route_table" "private_rt_b" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "private-rt-a"
  }
}

resource "aws_route_table_association" "rt_assoc_private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_rt_b.id
}

resource "aws_route" "route_private_b" {
  route_table_id         = aws_route_table.private_rt_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.public_ngw_b.id
}

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "ap-southeast-1a"
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "ap-southeast-1b"
}
