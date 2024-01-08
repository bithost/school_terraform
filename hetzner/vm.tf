resource "hcloud_server" "web" {
  count = 1
  name = "web-server-${count.index}"
  server_type = "cax11"
  image = "ubuntu-22.04"
  ssh_keys = [hcloud_ssh_key.ansible_key.id ]
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
    ip = "10.10.1.1${min(count.index + 1, 10)}"
    }
    
  # **Note**: the depends_on is important when directly attaching the
  # server to a network. Otherwise Terraform will attempt to create
  # server and sub-network in parallel. This may result in the server
  # creation failing randomly.
  depends_on = [
    hcloud_network_subnet.private-subnet
  ]
  user_data = file("user_data_vm.yml")
}

resource "hcloud_server" "load_balancer" {
  name = "lb-server"
  server_type = "cax11"
  image = "ubuntu-22.04"
  ssh_keys = [hcloud_ssh_key.ansible_key.id]
  location = "hel1"
  labels = {
    role = "lb"
  }
    public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
    network {
    network_id = hcloud_network.private-lan.id
    ip = "10.10.1.20"
    }
    
  # **Note**: the depends_on is important when directly attaching the
  # server to a network. Otherwise Terraform will attempt to create
  # server and sub-network in parallel. This may result in the server
  # creation failing randomly.
  depends_on = [
    hcloud_network_subnet.private-subnet
  ]
  user_data = file("test.sh")
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

