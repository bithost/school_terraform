#variable "vm_name" {
# description = "This is a variable of type string"
# type        = string
# default     = "saltcorn.lanlab.xyz"
#}

resource "hcloud_ssh_key" "default" {
  name       = "main_ssh_key"
  public_key = file("~/.ssh/id_rsa.pub")
}
resource "hcloud_ssh_key" "ansible" {
  name       = "ansible_ssh_key"
  public_key = file("~/.ssh/ansible.pub")
}

//main.tf
resource "hcloud_server" "controller" {
  name = "kube.lanlab.xyz"
  server_type = "cx11"
  image = "ubuntu-22.04"
  ssh_keys = [hcloud_ssh_key.default.id,hcloud_ssh_key.ansible.id, ]
  location = "hel1"
  labels = {
    role = "kube"
  }
}
