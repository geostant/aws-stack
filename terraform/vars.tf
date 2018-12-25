variable "AWS_PROFILE" {}

variable "AWS_REGION" {}

variable "AWS_INSTANCE_SIZE" {}

variable "AMIS" {
  type = "map"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "~/.ssh/id_rsa.pub"
}