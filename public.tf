resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "rd-igw"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "public-subnet-b"
  }
}

resource "aws_eip" "eip_a" {
  tags = {
    Name = "eip-a"
  }
}

resource "aws_eip" "eip_b" {
  tags = {
    Name = "eip-b"
  }
}

resource "aws_nat_gateway" "public_ngw_a" {
  allocation_id = aws_eip.eip_a.id
  subnet_id     = aws_subnet.public_a.id
  depends_on    = [aws_eip.eip_a]
  tags = {
    Name = "ngw-a"
  }
}

resource "aws_nat_gateway" "public_ngw_b" {
  allocation_id = aws_eip.eip_b.id
  subnet_id     = aws_subnet.public_b.id
  depends_on    = [aws_eip.eip_b]
  tags = {
    Name = "ngw-b"
  }
}

resource "aws_route_table" "public_rt_a" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "public-rt-a"
  }
}

resource "aws_route_table_association" "rt_assoc_public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt_a.id
}

resource "aws_route" "route_a" {
  route_table_id         = aws_route_table.public_rt_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_igw.id
}

resource "aws_route_table" "public_rt_b" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "public-rt-b"
  }
}

resource "aws_route_table_association" "rt_assoc_public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt_b.id
}

resource "aws_route" "route_b" {
  route_table_id         = aws_route_table.public_rt_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_igw.id
}


