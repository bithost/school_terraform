resource "hcloud_server" "web" {
  count = 1
  name = "web-server-${count.index}"
  server_type = "cax11"
  image = "ubuntu-22.04"
  #ssh_keys = [hcloud_ssh_key.default.id,hcloud_ssh_key.ansible.id, ]
  location = "hel1"
  labels = {
    role = "web"
  }
    public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }
    network {
    network_id = hcloud_network.private-lan.id
    ip = "10.10.1.${min(count.index + 1, 199)}"
    }
    
  # **Note**: the depends_on is important when directly attaching the
  # server to a network. Otherwise Terraform will attempt to create
  # server and sub-network in parallel. This may result in the server
  # creation failing randomly.
  depends_on = [
    hcloud_network_subnet.private-subnet
  ]
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

