resource "hcloud_load_balancer" "load_balancer" {
  name               = "school-lb"
  load_balancer_type = "lb11"
  location           = "nbg1"
  labels = {
    type = "web"
  }

  dynamic "target" {
    for_each = hcloud_server.web
    content {
      type      = "server"
      server_id = target.value["id"]
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

resource "hcloud_load_balancer_network" "web_network" {
  load_balancer_id        = hcloud_load_balancer.load_balancer.id
  subnet_id               = hcloud_network.private-lan.id
  enable_public_interface = "true"
  # **Note**: the depends_on is important when directly attaching the
  # server to a network. Otherwise Terraform will attempt to create
  # server and sub-network in parallel. This may result in the server
  # creation failing randomly.
  depends_on = [
    hcloud_network_subnet.private-subnet
  ]
}