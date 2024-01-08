resource "hcloud_ssh_key" "ansible_key" {
 name       = "ansible@ansible"
 public_key = file("ansible.pub")

}
