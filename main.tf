/*
    main.tf

    This is the main configuration file where you call the modules to
    provision your Vultr resources. This file is now very clean and readable.
*/

// Configure the Vultr provider with the API key.
provider "vultr" {
  api_key = var.vultr_api_key
}

// Data source to find your existing SSH key.
data "vultr_ssh_key" "my_key" {
  filter {
    name   = "name"
    values = [var.ssh_key_name]
  }
}

# // Call the 'vultr_instance' module to create a single server.
# module "my_server_instance" {
#   source       = "./modules/vultr_instance"
#   plan         = var.vultr_instance_plan
#   region       = var.vultr_region
#   label        = var.instance_label
#   os_id        = var.vultr_os_id
#   ssh_key_id   = data.vultr_ssh_key.my_key.id
# }

// Call the 'vultr_k8s_cluster' module to create a Kubernetes cluster.
module "my_k8s_cluster" {
  source       = "./modules/vultr_k8s_cluster"
  plan         = var.vultr_k8s_plan
  region       = var.vultr_region
  label        = var.cluster_label
  node_count   = var.node_count
  ssh_key_id   = data.vultr_ssh_key.my_key.id
}

