terraform {
  backend "s3" {
    bucket = "jayeshzimbal01"
    key = "terraform.tfstate"
    region = "ap-south-1"
    #use_lockfile = true
    dynamodb_table = "jayeshzimbal"
  }
}