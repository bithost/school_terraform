resource "hcloud_network" "school" {
  name     = "code-school"
  ip_range = "10.0.1.0/24"
}


//main.tf
resource "hcloud_server" "controller" {
  name = "kube.lanlab.xyz"
  server_type = "cx11"
  image = "ubuntu-22.04"
  #ssh_keys = [hcloud_ssh_key.default.id,hcloud_ssh_key.ansible.id, ]
  location = "hel1"
  labels = {
    role = "kube"
  }
    public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }
    network {
    network_id = hcloud_network.school.id
    ip         = "10.0.1.5"
    }
}


#variable "vm_name" {
# description = "This is a variable of type string"
# type        = string
# default     = "saltcorn.lanlab.xyz"
#}



#resource "hcloud_ssh_key" "default" {
 #name       = "tadas@code"
 #public_key = file("~/.ssh/id_rsa.pub")
#}
#resource "hcloud_ssh_key" "ansible" {
 #name       = "ansible@ansible"
 #public_key = file("~/.ssh/ansible.pub")

#

