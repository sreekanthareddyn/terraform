Create instance with a bootable storage volume
This example demonstrates creation of an instance with a persistent (block storage) bootable storage volume

The opc_compute_storage_volume resource is created from an existing image

bootable = true
image_list = "/oracle/public/OL_7.6_UEKR4_x86_64"
image_list_entry = 3
The opc_compute_instance resource is attached to the bootable storage volume and the bootOrder identifies the index of the specific storage attachement to boot from.

storage {
	index = 1
	volume = "${opc_compute_storage_volume.server-1-boot.name}"
}
bootOrder = [ 1 ]
