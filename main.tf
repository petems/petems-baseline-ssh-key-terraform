terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "2.3.3"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}

data "external" "todays_date" {
  program = ["sh", "-c", "echo \"{\\\"date\\\" : \\\"$(date +\"%d_%b_%Y\")\\\"}\""]
}

locals {
  current_date = "${data.external.todays_date.result.date}"
  filename     = "coolkids_ssh_key_${local.current_date}"
}

resource "tls_private_key" "baseline_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "local_sensitive_file" "baseline_private_key_local" {
  filename          = "${pathexpand("~/.ssh/")}/${local.filename}"
  content           = chomp(tls_private_key.baseline_key.private_key_pem)
  file_permission   = "0600"
}

resource "local_file" "baseline_public_key_local" {
  filename          = "${pathexpand("~/.ssh/")}/${local.filename}.pub"
  content           = chomp(tls_private_key.baseline_key.public_key_openssh)
  file_permission   = "0600"
}

output "ssh_key_path" {
  value = local_sensitive_file.baseline_private_key_local.filename
}

output "baseline_ssh_configfile" {
  value = <<EOT
Host fakeserver.example.xyz
  ControlMaster auto
  ControlPath ~/.ssh/ssh-%r@%h:%p
  ControlPersist yes
  IdentityFile ~/.ssh/${local.filename}
EOT
}