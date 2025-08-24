resource "vultr_instance" "server" {
  plan        = var.plan
  region      = var.region
  label       = var.label
  os_id       = var.os_id
  ssh_key_ids = [var.ssh_key_id]
}