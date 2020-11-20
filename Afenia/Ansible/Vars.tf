variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "myPublicIp" {
  default = "92.232.147.91/32"
}
variable "accountId" {
  default = "285436582846"
}
variable "AMIS" {
  type = map
  default = {
    us-east-1 = "ami-02354e95b39ca8dec"
  }
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "INSTANCE_USERNAME"{
  default = "ec2-user"
}
