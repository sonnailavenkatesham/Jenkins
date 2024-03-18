resource "aws_instance" "name" {
  count = length(var.instance_names)
  ami             = var.ami_id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.allow_all.name]
  user_data       = var.instance_names[count.index] == "Jenkins" ? "${file("jenkins.sh")}" : "${file("agent.sh")}"
  tags = merge({
    Name = var.instance_names[count.index]
  }, var.common_tags)
}