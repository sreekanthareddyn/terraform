provider "opc" {
  user            = "${var.user}"
  password        = "${var.password}"
  identity_domain = "${var.domain}"
  endpoint        = "${var.endpoint}"
}

resource "opc_compute_ssh_key" "my-ssh-key" {
  name    = "my-ssh-key"
  key     = "${file(var.public_ssh_key)}"
  enabled = true
}

resource "opc_compute_ip_address_reservation" "my-ip-address" {
  name            = "my-ip-address"
  ip_address_pool = "public-ippool"
}

resource "opc_compute_ip_network" "my-ip-network" {
  name              = "my-ip-network"
  ip_address_prefix = "10.0.1.0/24"
}

resource "opc_compute_acl" "my-acl" {
  name = "my-acl"
}
