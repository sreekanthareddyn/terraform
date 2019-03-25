# Creating Oracle Storage Container
resource "opc_storage_container" "oct_storage" {
  name = "${var.container_name}"
}
