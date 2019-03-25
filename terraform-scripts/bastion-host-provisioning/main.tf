variable "user" {}
variable "password" {}
variable "domain" {}
variable "endpoint" {}

provider "opc" {
  user            = "${var.user}"
  password        = "${var.password}"
  identity_domain = "${var.domain}"
  endpoint        = "${var.endpoint}"
}

resource "opc_compute_ssh_key" "bastion" {
  name    = "bastion_ssh"
  key     = "${file("./bastion_id_rsa.pub")}"
  enabled = true
}

resource "opc_compute_ssh_key" "instance" {
  name    = "instance_ssh"
  key     = "${file("./instance_id_rsa.pub")}"
  enabled = true
}

module "bastion-host" {
  source = "modules/bastion"
  ssh_public_key = "${opc_compute_ssh_key.bastion.name}"
  ssh_private_key = "${file("./bastion_id_rsa")}"
  private_ip_network = "${opc_compute_ip_network.private-ip-network.name}"
}

resource "opc_compute_ip_network" "private-ip-network" {
  name                = "private-ip-network"
  ip_address_prefix   = "10.0.1.0/24"
  public_napt_enabled = true
}

resource "opc_compute_instance" "private-instance" {
  name                = "private1"
  hostname            = "private1"
  shape               = "oc3"
  image_list          = "/oracle/public/OL_7.4_UEKR4_x86_64"
  ssh_keys            = [ "${opc_compute_ssh_key.instance.name}" ]

  networking_info {
    index          = 0
    shared_network = "false"
    ip_network     = "${opc_compute_ip_network.private-ip-network.name}"
  }

  connection {
    type        = "ssh"
    host        = "${self.ip_address}"
    user        = "opc"
    private_key = "${file("./instance_id_rsa")}"

    bastion_host        = "${module.bastion-host.bastion_public_ip}"
    bastion_user        = "${module.bastion-host.bastion_user}"
    bastion_private_key = "${module.bastion-host.bastion_private_key}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'This instance was provisioned by Terraform.' | sudo tee /etc/motd"
    ]
  }
}
