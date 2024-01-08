resource "hcloud_ssh_key" "ansible_key" {
 name       = "ansible@automation"
 public_key = file("ansible.pub")

}
