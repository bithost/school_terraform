#!/bin/bash

cat << 'EOF' > cloud-init-script.sh
#cloud-config
users:
  - name: ansible
    groups: users, admin
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCq8c4ByK/AiDCeep1xdwaq3Hv3Rxbqga0iB3VPMENE7AEBpwExDGxUXUbYEOjTfy1aNhupHp4GVwIeL/WDQzPbSgnbT9RVqjhMm+XdWoaX+0c2v32Q8UBYvFsh44bhEW+GqHPjEX0Z1ee+BdcPkvo7pSFQW8Uyfahe0dw9mVHKHsgQAbPVReHcaisWgQxHoC7lSvPbBXsUxljyuh0QtAI717LDaQQeWLsBSffZsa4AfdZUYWjHl/sBmGWRVW8Bgj1L4rXEWce0mhzJn0hztcMI6ihaM9b1oxBf+sidIKlQQhQfzohgvhT73vY1eaHf7nbfFPsI5LOo3TrY5McgC8DpeUrf0nxIEaQsztKP4kqWmL4wogSu4NiaNqZqUuw/tAKcGd06VkNwEr+KqLqeBYuM09i3sJ9jUiE1q3f/1ARNrN27E8UbcQSCIDGYsJxD6Xun0lcXnz1o8mHJWIF2JkqxuIiL0SpdP+cjUvsPYbCiU7H9dChB+gomSYzLCpdY+a0= ansible@ansible
package_update: true
package_upgrade: true
apt_upgrade: true
apt:
    sources:
        caddy:
            keyid: FDF3079D8A18AC6F
            source: deb [signed-by=/usr/share/keyrings/caddy-stable-archive-keyring.gpg] https://dl.cloudsmith.io/public/caddy/stable/deb/ubuntu focal main
packages:
  - caddy
  - ufw
runcmd:
  - systemctl enable caddy
  - ufw allow 'Caddy HTTP'
  - ufw allow 'OpenSSH'
  - ufw enable
  - curl https://my-netdata.io/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --nightly-channel --claim-token Ec04MWdZLjQy7I2df2QLvi8QyEVxdYrW7WgI8FvAUHIazA3XkaoSPkmymxFQE-04N6GZdgF29qBqHQmaA1RIo6BrC-5uP-2wwznHDesdYINNiPsIa82i3brwk9e9KpSCDH_n2CM --claim-rooms 603437f5-ab76-4a58-8fd1-afdd8f67f460 --claim-url https://app.netdata.cloud
EOF

chmod +x cloud-init-script.sh
