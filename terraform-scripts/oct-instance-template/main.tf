resource "opc_compute_storage_volume" "oct_volume" {
  size             = "${var.volume_size}"
  name             = "${var.volume_name}"
  bootable         = true
  image_list       = "/oracle/public/OL_7.6_UEKR4_x86_64"
  image_list_entry = 3
}

resource "opc_compute_instance" "oct_instance" {
  name            = "${var.instance_name}"
  label           = "${var.label}"
  shape           = "${var.vm_shape}"

  storage {
    index  = 1
    volume = "${opc_compute_storage_volume.oct_volume.name}"
  }
}

resource "opc_compute_security_association" "instance_sec_list_assoc" {
  name    = "${var.association}"
  vcable  = "${opc_compute_instance.oct_instance.vcable}"
  seclist = "${var.sec_list_name}"
}
