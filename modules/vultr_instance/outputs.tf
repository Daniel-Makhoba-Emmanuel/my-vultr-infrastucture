output "server_ip" {
  description = "The main IP address of the created server."
  value       = vultr_instance.server.main_ip
}

output "server_label" {
  description = "The label of the created server."
  value       = vultr_instance.server.label
}