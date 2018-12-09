resource "aws_instance" "bastion" {
  ami                         = "${data.aws_ami.redhat.id}"
  instance_type               = "t2.micro"
  key_name                    = "sandbox"
  subnet_id                   = "${aws_subnet.dmz.id}"
  security_groups             = ["${aws_security_group.bastion.id}"]
  associate_public_ip_address = true

  tags {
    Name = "bastion"
  }
}

output "ip-address" {
  value = "${aws_instance.bastion.public_ip}"
}
