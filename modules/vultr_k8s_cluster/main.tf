resource "vultr_kubernetes" "cluster" {
  region    = var.region
  label     = var.label
  version   = "v1.32.4+3"

  node_pools {
      node_quantity = var.node_count
      plan          = var.plan
      label         = "default-node-pool"
    
  }
}
