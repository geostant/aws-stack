# Internet VPC
resource "aws_vpc" "packerVPC" {
  cidr_block           = "192.168.50.0/24"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "packerVPC"
  }
}

# Subnets
resource "aws_subnet" "packerVPC-public-1" {
  vpc_id                  = "${aws_vpc.packerVPC.id}"
  cidr_block              = "192.168.50.0/24"
  map_public_ip_on_launch = "true"
  # TODO: Extract availability zones to variable from ansible
  availability_zone       = "us-east-1a"

  tags {
    Name = "packerVPC-public-1"
  }
}

# resource "aws_subnet" "packerVPC-private-1" {
#   vpc_id                  = "${aws_vpc.packerVPC.id}"
#   cidr_block              = "10.0.50.0/24"
#   map_public_ip_on_launch = "false"
#   availability_zone       = "us-east-1a"

#   tags {
#     Name = "packerVPC-private-1"
#   }
# }

# Internet GW
resource "aws_internet_gateway" "packerVPC-gw" {
  vpc_id = "${aws_vpc.packerVPC.id}"

  tags {
    Name = "packerVPC"
  }
}

# route tables
resource "aws_route_table" "packerVPC-public" {
  vpc_id = "${aws_vpc.packerVPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.packerVPC-gw.id}"
  }

  tags {
    Name = "packerVPC-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "packerVPC-public-1-a" {
  subnet_id      = "${aws_subnet.packerVPC-public-1.id}"
  route_table_id = "${aws_route_table.packerVPC-public.id}"
}