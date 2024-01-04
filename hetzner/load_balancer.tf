resource "hcloud_load_balancer" "load_balancer" {
  name               = "school-lb"
  load_balancer_type = "lb11"
  location           = "nbg1"
  labels = {
    role = "kube"
  }
}
