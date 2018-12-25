provider "aws" {
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "${var.AWS_PROFILE}"
  region                  = "${var.AWS_REGION}"
}
