resource "aws_security_group" "bastion" {
    vpc_id = "${aws_vpc.private.id}"
    tags {
        Name = "nat-gateway"
    }
}

resource "aws_security_group_rule" "bastion-ssh" {
    security_group_id = "${aws_security_group.bastion.id}"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    type = "ingress"
    protocol = "tcp"
}