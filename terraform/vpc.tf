resource "google_compute_address" "appserver" {
  name = "appserver-static"
}

resource "google_compute_address" "webserver" {
  name = "webserver-static"
}
