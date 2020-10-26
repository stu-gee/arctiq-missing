# Firewall for webserver
resource "google_compute_firewall" "webserver-fw" {
  name    = "webserver-fw"
  network = "default"

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

  source_tags   = ["web"]
  target_tags   = ["app"]
}

# Firewall for dbserver
resource "google_compute_firewall" "dbserver-fw" {
  name    = "dbserver-fw"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }

  source_tags   = ["app"]
  target_tags   = ["sql"]
}