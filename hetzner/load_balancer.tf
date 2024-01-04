resource "hcloud_load_balancer" "load_balancer" {
  name               = "school-load-balancer"
  load_balancer_type = "lb11"
  location           = "nbg1"
  labels = {
    role = "kube"
  }
}
