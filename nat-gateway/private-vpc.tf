resource "aws_vpc" "private" {
    tags {
        Name = "private"
    }

    cidr_block = "10.0.0.0/22"
}

resource "aws_subnet" "dmz" {
    vpc_id = "${aws_vpc.private.id}"
    cidr_block = "10.0.0.0/28"
}    