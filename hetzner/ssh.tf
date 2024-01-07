resource "hcloud_ssh_key" "ansible" {
 name       = "ansible@ansible"
 public_key = file("ansible.pub")

}
