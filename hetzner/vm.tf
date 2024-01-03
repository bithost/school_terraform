resource "hcloud_network" "network" {
  name     = "network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "network-subnet" {
  type         = "cloud"
  network_id   = hcloud_network.network.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

resource "hcloud_network" "private-lan" {
  name     = "private-lan"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "private-subnet" {
  type         = "cloud"
  network_id   = hcloud_network.private-lan.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}


//main.tf
resource "hcloud_server" "kube" {
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
    network_id = hcloud_network.private-lan.id
    ip = "10.0.1.5"
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

