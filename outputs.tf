/*
    outputs.tf

    This file defines the output values for your OpenTofu configuration.
    It's crucial for a Kubernetes cluster to export the kubeconfig file,
    which you will use to connect to and manage your cluster.
*/

// Output from the single Vultr instance.
# output "server_ip" {
#   description = "The main IP address of the single server."
#   value       = module.my_server_instance.server_ip
# }

// Output from the Kubernetes cluster.
output "kubeconfig" {
  description = "The kubeconfig file content for the cluster."
  value       = module.my_k8s_cluster.kubeconfig
  sensitive   = true
}

