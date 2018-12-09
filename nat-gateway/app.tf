resource "aws_vpc" "app" {
  cidr_block           = "10.0.1.0/24"
  enable_dns_hostnames = true

  tags {
    Name = "app"
  }
}

resource "aws_subnet" "app" {
  vpc_id     = "${aws_vpc.app.id}"
  cidr_block = "10.0.1.0/24"
}

resource "aws_vpc_peering_connection" "app" {
  vpc_id      = "${aws_vpc.app.id}"
  peer_vpc_id = "${aws_vpc.dmz.id}"
}

resource "aws_default_route_table" "app" {
  route {
    cidr_block                = "10.0.0.0/24"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.app.id}"
  }

  default_route_table_id = "${aws_vpc.app.default_route_table_id}"
}
