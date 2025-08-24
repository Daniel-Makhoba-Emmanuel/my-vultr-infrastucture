output "cluster_id" {
  description = "The ID of the newly created Kubernetes cluster."
  value       = vultr_kubernetes_cluster.cluster.id
}

output "kubeconfig" {
  description = "The kubeconfig file content for the cluster."
  value       = vultr_kubernetes_cluster.cluster.kube_config
  sensitive   = true
}

output "api_server" {
  description = "The API server endpoint for the cluster."
  value       = vultr_kubernetes_cluster.cluster.api_server
}