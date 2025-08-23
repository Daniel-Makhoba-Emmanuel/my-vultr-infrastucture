variable "vultr_api_key" {
  description = "Your personal Vultr API key. This is a sensitive value."
  type        = string
}

variable "vultr_region" {
  description = "The Vultr region to deploy the instance in (e.g., 'ewr' for New Jersey)."
  type        = string
  default     = "ewr"
}

variable "vultr_plan" {
  description = "The Vultr plan ID for the instance (e.g., 'vc2-1c-512mb')."
  type        = string
  default     = "vc2-1c-512mb"
}

variable "vultr_os_id" {
  description = "The Vultr OS ID for the instance (e.g., '387' for Ubuntu 22.04)."
  type        = number
  default     = 387
}

variable "server_label" {
  description = "A friendly label for the server instance."
  type        = string
  default     = "my-vultr-server"
}

variable "ssh_key_name" {
  description = "A name for the SSH key to be uploaded to Vultr."
  type        = string
  default     = "opentofu-key"
}

variable "ssh_public_key" {
  description = "The public SSH key string. Use the `file()` function to read from a local file."
  type        = string
}

variable "ssh_private_key_path" {
  description = "The path to the private key corresponding to the public key. Used for remote-exec."
  type        = string
}