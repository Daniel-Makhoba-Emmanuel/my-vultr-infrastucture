variable "plan" {
  type        = string
  description = "The Vultr plan ID for the cluster's worker nodes."
}

variable "region" {
  type        = string
  description = "The Vultr region to deploy the cluster in."
}

variable "label" {
  type        = string
  description = "A friendly label for the Kubernetes cluster."
}

variable "node_count" {
  type        = number
  description = "The number of nodes in the Kubernetes cluster."
}

variable "ssh_key_id" {
  type        = string
  description = "The Vultr ID of the SSH key to use."
}