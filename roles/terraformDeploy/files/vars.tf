variable "AWS_PROFILE" {}

variable "AWS_REGION" {}

variable "AWS_INSTANCE_SIZE" {}

variable "AWS_AVAILABILITY_ZONES" {}
variable "AMIS" {
  type = "map"
}

variable "AMI_ID" {}

variable "PATH_TO_PUBLIC_KEY" {
  default = "~/.ssh/id_rsa.pub"
}
