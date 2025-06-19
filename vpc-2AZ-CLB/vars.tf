variable "aws_region" {
  default = "ap-south-1"
}
variable "azs-1" {
  default = "ap-south-1a"
}
variable "azs-2" {
  default = "ap-south-1b"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_subnet_1a_cidr" {
  default = "10.0.0.0/27"
}
variable "public_subnet_1b_cidr" {
  default = "10.0.0.32/27"
}
variable "private_subnet_1a_cidr" {
  default = "10.0.0.64/27"
}
variable "private_subnet_1b_cidr" {
  default = "10.0.0.96/27"
}
