resource "aws_vpc" "dmz" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_hostnames = true

  tags {
    Name = "dmz"
  }
}

resource "aws_vpc_peering_connection_accepter" "dmz" {
  auto_accept               = true
  vpc_peering_connection_id = "${aws_vpc_peering_connection.app.id}"
}

resource "aws_internet_gateway" "dmz" {
  vpc_id = "${aws_vpc.dmz.id}"
}

resource "aws_subnet" "dmz" {
  vpc_id                  = "${aws_vpc.dmz.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
}

resource "aws_default_route_table" "dmz" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dmz.id}"
  }

  route {
    cidr_block                = "10.0.1.0/24"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.app.id}"
  }

  default_route_table_id = "${aws_vpc.dmz.default_route_table_id}"
}
