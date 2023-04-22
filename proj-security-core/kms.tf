module "kms" {
  source = "git@github.com:GoogleCloudPlatform/cloud-foundation-fabric.git//modules/kms?ref=v21.0.0"

  project_id = var.project_id
  key_iam_additive = {
    vault-key = {
      "roles/cloudkms.cryptoKeyEncrypterDecrypter" = [
        module.vault_service_account.iam_email
      ],
      "roles/cloudkms.viewer" = [
        module.vault_service_account.iam_email
      ]
    }
  }
  keyring = {
    location = var.region
    name     = "vault-kms"
  }
  keys = {
    vault-key = {
      rotation_period = "604800s", # rotate every 7 days
      labels          = null
    }
  }
}