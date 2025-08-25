output "cluster_id" {
  description = "The ID of the newly created Kubernetes cluster."
  value       = vultr_kubernetes.cluster.id
}

output "kubeconfig" {
  description = "The kubeconfig file content for the cluster."
  value       = vultr_kubernetes.cluster.kube_config
  sensitive   = true
}

