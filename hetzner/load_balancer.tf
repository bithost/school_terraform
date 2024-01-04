resource "hcloud_load_balancer" "load_balancer" {
  name               = "school-lb"
  load_balancer_type = "lb11"
  location           = "hel1"
  labels = {
    type = "web"
  }

  dynamic "target" {
    for_each = hcloud_server.web
    content {
      type      = "server"
      server_id = target.value.id
    }
  }

  algorithm {
    type = "round_robin"
  }
}
resource "hcloud_load_balancer_service" "web_lb_service" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  protocol         = "http"
  listen_port      = "80"
  destination_port = "80"

  health_check {
    protocol = "http"
    port     = "80"
    interval = "10"
    timeout  = "10"
    http {
      path         = "/"
      status_codes = ["2??", "3??"]
    }
  }
}

resource "hcloud_server_network" "srvnetwork" {
  server_id  = hcloud_load_balancer.load_balancer.id
  network_id = hcloud_network.private-lan.id
  ip         = "10.10.1.15"

}