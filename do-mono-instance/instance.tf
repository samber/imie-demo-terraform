
resource "digitalocean_droplet" "api" {
  image  = "debian-8-x64"
  name   = "api"
  region = "lon1"
  size   = "1gb"

  ssh_keys = [
    8407171,
    8400544
  ]
}
