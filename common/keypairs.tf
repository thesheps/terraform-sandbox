resource "aws_key_pair" "sandbox" {
  key_name = "sandbox"
  public_key = "${file("~/.ssh/sandbox.pem")}"
}