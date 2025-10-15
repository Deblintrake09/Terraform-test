resource "aws_instance" "web" {
  ami                    = var.amiID[var.region]
  instance_type          = "t3.micro"
  key_name               = "test-key"
  vpc_security_group_ids = [aws_security_group.test-sg.id]
  availability_zone      = var.zone

  tags = {
    Name    = "Test-web"
    project = "Terraform-test"
  }
}

resource "aws_ec2_instance_state" "web_state" {
  instance_id = aws_instance.web.id
  state       = "running"
}
