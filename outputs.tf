output "server_ip" {
  description = "The main IP address of the newly created server."
  value       = vultr_instance.my_server.main_ip
}

output "server_label" {
  description = "The label of the server."
  value       = vultr_instance.my_server.label
}

output "ssh_key_id" {
  description = "The ID of the SSH key that was uploaded to Vultr."
  value       = data.vultr_ssh_key.my_key.id
}