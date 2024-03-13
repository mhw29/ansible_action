provider "github" {
  token = var.github_token
}

resource "github_repository" "this" {
  name        = "ansible_action"
  description = "This repository stores the github action example running a playbook with ansible using awx"
  private     = true

}

resource "github_actions_secret" "public_ip" {
  repository       = github_repository.this.name
  secret_name      = "public_ip"
  plaintext_value  = module.aws.public_ip
}

resource "github_actions_secret" "ssh_private_key" {
  repository       = github_repository.this.name
  secret_name      = "SSH_PRIVATE_KEY"
  plaintext_value  = file("~/.ssh/id_ed25519")
}

# resource "github_actions_variable" "public_ip" {
#   repository       = github_repository.this.name
#   variable_name    = "PUBLIC_IP"
#   value            = module.aws.public_ip
# }

# resource "github_actions_variable" "ssh_private_key" {
#   repository       = github_repository.this.name
#   variable_name    = "SSH_PRIVATE_KEY"
#   value            = file("~/.ssh/id_ed25519")
# }

module "aws" {
  source = "./aws"
}