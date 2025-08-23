// Configure the Vultr provider with the API key and region.
provider "vultr" {
  api_key = var.vultr_api_key
}

// Define a Vultr SSH Key resource.
// This allows you to securely access your server after it's provisioned.
resource "vultr_ssh_key" "my_key" {
  name        = var.ssh_key_name
  ssh_key = var.ssh_public_key
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
  ssh_key_ids = [vultr_ssh_key.my_key.id]

  // A common and helpful practice is to use a provisioner to run commands
  // on the newly created server. This example updates the system packages.
  // Note: This requires the server to be online and accessible.
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      host        = self.main_ip
      private_key = file(var.ssh_private_key_path)
    }
  }
}