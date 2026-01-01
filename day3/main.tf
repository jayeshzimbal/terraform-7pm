resource "aws_instance" "name" {
    ami = var.jayesh
    instance_type = var.jay
  

  tags = {
    Name        = "Day3"
    
  }


}