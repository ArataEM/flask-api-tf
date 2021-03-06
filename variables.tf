variable "profile" {
  type = string
  default = "devops"
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-central-1a","eu-central-1b"]
}

variable "image_id" {
  type = string
  default = "ami-065deacbcaac64cf2"
}

variable "replicas" {
  type = number
  default = 1
}

variable "public_key" {
  type = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "rds_login" {
  type = string
  default = "devops"
}

variable "rds_password" {
  type = string
  default = "devops"
}
