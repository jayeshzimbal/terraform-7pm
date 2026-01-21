provider "aws" {
  region = "ap-south-1"
}

# Get latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]   # Canonical (Ubuntu) owner ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_security_group" "allow_ssh_http" {
  name = "allow-ssh-http"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "Mykey"

  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  tags = {
    Name = "Provisioner-EC2"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("Mykey.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install apache2 -y",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2",
      "echo Hello Aaba from Terraform Provisioner | sudo tee /var/www/html/index.html"
    ]
  }
}
