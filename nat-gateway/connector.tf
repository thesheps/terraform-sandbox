resource "aws_instance" "connector" {
  ami                         = "${data.aws_ami.redhat.id}"
  instance_type               = "t2.micro"
  key_name                    = "${module.common.aws_key_pair}"
  subnet_id                   = "${aws_subnet.app.id}"
  security_groups             = ["${aws_security_group.connector.id}"]
  associate_public_ip_address = false

  tags {
    Name = "connector"
  }
}

resource "aws_security_group" "connector" {
  vpc_id = "${aws_vpc.app.id}"
}

resource "aws_security_group_rule" "connector-ssh" {
  security_group_id        = "${aws_security_group.connector.id}"
  from_port                = 22
  to_port                  = 22
  type                     = "ingress"
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion.id}"
}
