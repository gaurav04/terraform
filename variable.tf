variable "aws_access_key_id" {
  default = ""
}

variable "aws_secret_access_key" {
  default = ""
}

variable "aws_region" {
  default = "us-east-1"
}

variable "availability_zone" {
  default = {
    "primary" = "us-east-1a",
    "secondary" = "us-east-1b"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0d729a60"
}
