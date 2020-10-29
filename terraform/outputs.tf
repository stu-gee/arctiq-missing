output "webapp-URL" {
  value = "http://${google_compute_instance.instance["webserver"].network_interface.0.access_config.0.nat_ip}"
}

resource "local_file" "inventory" {

  content = templatefile("inventory.cfg",
    {
      appserver_ip = google_compute_instance.instance["appserver"].network_interface.0.access_config.0.nat_ip
      webserver_ip = google_compute_instance.instance["webserver"].network_interface.0.access_config.0.nat_ip
      dbserver_ip = google_compute_instance.instance["dbserver"].network_interface.0.access_config.0.nat_ip
    }
  )
  filename = "../ansible/inventory"
}
