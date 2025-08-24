resource "vultr_kubernetes_cluster" "cluster" {
  region       = var.region
  label        = var.label
  version      = "v1.28.6"
  node_pools {
    node_quantity = var.node_count
    plan          = var.plan
    label         = "default-node-pool"
    ssh_keys      = [var.ssh_key_id]
  }
}