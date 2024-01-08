resource "hcloud_network" "private-lan" {
  name     = "private-lan"
  ip_range = "10.10.0.0/16"
}

resource "hcloud_network_subnet" "private-subnet" {
  type         = "cloud"
  network_id   = hcloud_network.private-lan.id
  network_zone = "eu-central"
  ip_range     = "10.10.1.0/24"
}
resource "hcloud_network_route" "privNet" {
  network_id  = hcloud_network.private-lan.id
  destination = "10.10.1.0/24"
  gateway     = "10.0.1.1"
}