resource "aws_instance" "bastion" {
  ami                         = "${data.aws_ami.redhat.id}"
  instance_type               = "t2.micro"
  key_name                    = "${module.common.aws_key_pair}"
  subnet_id                   = "${aws_subnet.dmz.id}"
  security_groups             = ["${aws_security_group.bastion.id}"]
  associate_public_ip_address = true

  tags {
    Name = "bastion"
  }
}

resource "aws_security_group" "bastion" {
  vpc_id = "${aws_vpc.dmz.id}"
}

resource "aws_security_group_rule" "bastion-ssh-ingress" {
  security_group_id = "${aws_security_group.bastion.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  type              = "ingress"
  protocol          = "tcp"
}

resource "aws_security_group_rule" "bastion-ssh-egress" {
  security_group_id = "${aws_security_group.bastion.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  type              = "egress"
  protocol          = "tcp"
}

output "ip-address" {
  value = "${aws_instance.bastion.public_ip}"
}
