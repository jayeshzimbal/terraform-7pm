module "server" {
  source = "../day8-modules"

  ami_id        = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.medium"
  instance_name = "prod-ec2"
  
}
