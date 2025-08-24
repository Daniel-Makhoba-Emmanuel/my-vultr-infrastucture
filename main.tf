/*
    main.tf

    This is the main configuration file where you define the Vultr
    provider and the resources you want to create, such as a cloud server
    and an SSH key. It uses the variables defined in `variables.tf`.
*/

// Configure the Vultr provider with the API key and region.
// This is updated to use an environment variable directly.
provider "vultr" {
  api_key = var.vultr_api_key
}

data "vultr_ssh_key" "my_key" {
  // Use a filter to find the SSH key by its name.
  filter {
    name = "name"
    values = [var.ssh_key_name]
  }
}

// Define a Vultr cloud instance (server) resource.
// The `plan`, `region`, and `os_id` are critical arguments.
// You can find a list of available plans, regions, and OS IDs in the
// Vultr API documentation.
resource "vultr_instance" "my_server" {
  plan   = var.vultr_plan
  region = var.vultr_region
  label  = var.server_label
  os_id  = var.vultr_os_id
  // Use the ID from the data source for your existing key.
  ssh_key_ids = [data.vultr_ssh_key.my_key.id]
}
