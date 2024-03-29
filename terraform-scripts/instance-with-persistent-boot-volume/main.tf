provider "opc" {
  user            = "${var.user}"
  password        = "${var.password}"
  identity_domain = "${var.domain}"
  endpoint        = "${var.endpoint}"
}

resource "opc_compute_storage_volume" "volume1" {
  size             = "12"
  description      = "Example bootable storage volume"
  name             = "boot-from-storage"
  bootable         = true
  image_list       = "/oracle/public/OL_7.6_UEKR4_x86_64"
  image_list_entry = 3
}

resource "opc_compute_storage_volume" "volume2" {
  size        = "4"
  description = "Example persistent storage volume"
  name        = "persistent-storage"
}

resource "opc_compute_instance" "instance1" {
  name  = "boot-from-storage-instance1"
  label = "Example instance with bootable storage"
  shape = "oc3"

  storage {
    index  = 1
    volume = "${opc_compute_storage_volume.volume1.name}"
  }

  storage {
    index  = 2
    volume = "${opc_compute_storage_volume.volume2.name}"
  }

  boot_order = [1]
}
