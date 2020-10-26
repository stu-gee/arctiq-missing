# Firewall for webserver
resource "google_compute_firewall" "webserver-fw" {
  name    = "webserver-fw"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}

# Firewall for appserver
resource "google_compute_firewall" "appserver-fw" {
  name    = "appserver-fw"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  #source_ranges = ["${google_compute_instance.webserver.network_interface.0.network_ip}/32"]
  source_tags   = ["web"]
  target_tags   = ["app"]
}