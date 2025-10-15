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


  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("test-key")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ip.txt"
  }
}

resource "aws_ec2_instance_state" "web_state" {
  instance_id = aws_instance.web.id
  state       = "running"
}

output "WebPublicIp" {
  description = "Public IP of Web instance"
  value       = aws_instance.web.public_ip
}
output "WebPrivateIp" {
  description = "Private IP of Web instance"
  value       = aws_instance.web.private_ip
}
