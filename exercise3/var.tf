variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0182f373e66f89c85"
    us-east-2 = "ami-09efc42336106d2f2"
  }
}
variable "USER" {
  default = "ec2-user"

}
