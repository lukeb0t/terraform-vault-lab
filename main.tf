provider "vault" {
  address = "http://localhost:8200"
  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = var.login_approle_role_id
      secret_id = var.login_approle_secret_id
    }
  }
}

data "vault_generic_secret" "vmware_creds" {
  path = "infrastructure_creds/vmware"
}

data "vault_generic_secret" "postgres_creds" {
  path = "databases/creds/dba"
}

output "postgres_pw"{
  value = data.vault_generic_secret.postgres_creds.data["password"]
  sensitive = true
  }

output "postgres_user"{
  value = data.vault_generic_secret.postgres_creds.data["username"]
  sensitive = true
  }

output "vmware_username"{
  value = data.vault_generic_secret.vmware_creds.data["username"]
  sensitive = true
  }

output "vmware_password"{
  value = data.vault_generic_secret.vmware_creds.data["password"]
  sensitive = true
  }

  locals {
    vmware_pw = data.vault_generic_secret.vmware_creds.data["username"]
  }

