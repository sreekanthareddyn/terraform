c_ssh_key" {}

variable "server_count" {
  default = 1
}

variable "name" {}

variable "shape" {
  default = "oc3"
}

variable "image_list" {
  default = "/oracle/public/OL_7.6_UEKR4_x86_64"
}

variable "ip_network" {}
