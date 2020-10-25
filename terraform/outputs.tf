output "webapp-ip" {
  value = "http://${google_compute_instance.appserver.network_interface.0.access_config.0.nat_ip}"
}