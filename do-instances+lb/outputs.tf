
output  "ipv4_servers"  { value = ["${digitalocean_droplet.api.*.ipv4_address}"] }
output  "ipv4_lb"       { value = "${digitalocean_loadbalancer.api.ip}" }
