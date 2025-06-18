variable "aws_region" {
  default = "ap-south-1"
}
variable "azs" {
  default = "ap-south-1a"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  default = "10.0.0.0/27"
}
variable "private_subnet_cidr" {
  default = "10.0.0.32/27"
}
