Create instance from a colocated storage snapshot
This code creating an instance with a persistent (block storage) bootable storage volume created from a colocated storage volume snapshot.

The opc_compute_storage_volume_snapshot data source is used to reference an existing storage volume snapshot already created in the domain. Note that the name of the snapshot is the composition of the storage volume name and snapshot name.

data "opc_compute_storage_volume_snapshot" "snapshot1" {
  name = "my-bootable-storage-volume/my-colocated-snapshot"
}
For colocated snapshots the source snapshot for the new opc_compute_storage_volume resource must be identified by the fully qualified snapshot name. The snapshot size attribute can be used to correctly set the size of the new volume.

resource "opc_compute_storage_volume" "volume1" {
  ...
  snapshot = "/Compute-${var.domain}/${var.user}/${data.opc_compute_storage_volume_snapshot.snapshot1.name}"
  size     = "${data.opc_compute_storage_volume_snapshot.snapshot1.size}"
}
The opc_compute_instance resource is attached to the bootable storage volume and the bootOrder identifies the index of the specific storage attachment to boot from.

resource "opc_compute_instance" "instance1" {
  ...
  storage {
  	index = 1 volume = "${opc_compute_storage_volume.volume1.name}"
  }
  bootOrder = [ 1 ]
}
