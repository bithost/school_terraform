title: CodeAccademy Project {
  near: top-center
  shape: text
  style: {
    font-size: 29
    bold: true
    underline: true
  }
}

# Actors
devops: DevOps

evironment: {
  github: Github
  infiscal: Infiscal Vault
  Terraform Cloud: Terraform Cloud
  hetzner: Hetzner Cloud

  github -> Terraform Cloud: Push changes
  infiscal -> Terraform Cloud: Gets all secrets required for run
  Terraform Cloud -> Hetzner: Terraform run plan and apply
}

# Accusations
devops -> evironment: 'git push to school_terraform'

# Claim
evironment.terraform cloud -> devops: Returns result for the user

