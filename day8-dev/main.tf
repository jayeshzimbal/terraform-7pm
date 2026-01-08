module "server" {
  source = "../day8-modules"

  ami_id        = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  instance_name = "dev-ec2"
 
}
