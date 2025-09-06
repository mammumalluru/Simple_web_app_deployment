resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.Jenkins_sg_group.id]
  subnet_id = data.aws_subnets.default_subnets.ids[0]
  key_name = var.key_name
  user_data = file("config.sh")

  tags = { 
    Name = "Jenkins"
  }
}