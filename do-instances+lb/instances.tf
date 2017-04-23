

resource "digitalocean_droplet" "api" {
  image  = "debian-8-x64"
  name   = "api-${count.index}"
  region = "lon1"
  size   = "512mb"
  count  = 3

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get -y install apt-transport-https ca-certificates",
      "curl -sSL https://get.docker.com | sh",
      "docker run -d -p 80:8000 jwilder/whoami"
    ]

    connection {
      type     = "ssh"
      private_key = "${file("~/.ssh.imie/id_rsa")}"
      user     = "root"
      timeout  = "10m"
    }
  }

  ssh_keys = [
    8407171,
    8400544
  ]
}


resource "digitalocean_loadbalancer" "api" {
  name = "lb-api-1"
  region = "lon1"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 80
    target_protocol = "http"
  }

  healthcheck {
    port = 80
    protocol = "tcp"
  }

  droplet_ids = ["${digitalocean_droplet.api.*.id}"]
}
