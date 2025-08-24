vultr_api_key = "GCKBBYC4CDWXAMTTK74BR3NPDVTHXVUCICVQ"

server_label = "minimal-vultr-server"

// The file() function is used here as it is supported within a .tfvars file
// ssh_public_key = file("~/.ssh/vultr_key.pub") // This is no longer needed

ssh_private_key_path = "~/.ssh/vultr_key"