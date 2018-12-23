provider "aws" {
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "ecdev"
  region                  = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-09cded360a00d8379"
  instance_type = "t2.micro"
}
