variable "plan" {
  type        = string
  description = "The Vultr plan ID for the instance."
}

variable "region" {
  type        = string
  description = "The Vultr region to deploy the instance."
}

variable "label" {
  type        = string
  description = "A friendly label for the server instance."
}

variable "os_id" {
  type        = number
  description = "The Vultr OS ID for the instance."
}

variable "ssh_key_id" {
  type        = string
  description = "The Vultr ID of the SSH key to use."
}