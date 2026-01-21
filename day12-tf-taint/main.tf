
provider "aws" {
  
}
resource "aws_instance" "server" {
  ami                         = "ami-0261755bbcb8c4a84" # Ubuntu AMI
  instance_type               = "t2.micro"

  tags = {
    Name = "UbuntuServer"
  }
}

#Use terraform taint to manually mark the resource for recreation:
# terraform taint aws_instance.server
# terraform apply
