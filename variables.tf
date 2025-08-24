/*
    variables.tf

    This file declares the variables that your main configuration will use.
*/

variable "vultr_api_key" {
  description = "Your personal Vultr API key."
  type        = string
}

variable "vultr_region" {
  description = "The Vultr region to deploy resources in (e.g., 'ewr' for New Jersey)."
  type        = string
  default     = "ewr"
}

variable "vultr_instance_plan" {
  description = "The Vultr plan for the single instance."
  type        = string
  default     = "vc2-1c-512mb"
}

variable "vultr_os_id" {
  description = "The Vultr OS ID for the instance (e.g., '387' for Ubuntu 22.04)."
  type        = number
  default     = 387
}

variable "instance_label" {
  description = "A friendly label for the server instance."
  type        = string
  default     = "my-vultr-server"
}

variable "vultr_k8s_plan" {
  description = "The Vultr plan for the cluster's worker nodes (e.g., 'vhf-1c-2gb')."
  type        = string
  default     = "vhf-1c-2gb"
}

variable "cluster_label" {
  description = "A friendly label for the Kubernetes cluster."
  type        = string
  default     = "my-k8s-cluster"
}

variable "ssh_key_name" {
  description = "The name of the SSH key already uploaded to Vultr."
  type        = string
  default     = "vultr_account_public_ssh_key"
}

variable "node_count" {
  description = "The number of nodes in the Kubernetes cluster."
  type        = number
  default     = 2
}