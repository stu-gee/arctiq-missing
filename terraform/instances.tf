# Configure instances based on map values from var.intances file
resource "google_compute_instance" "instance" {
  for_each = var.INSTANCES

  name         = each.key
  machine_type = var.MACHINE_TYPE

  # Tag it for firewall assignment
  tags = [each.value.tags]

  boot_disk {
    initialize_params {
      image = var.IMAGE
    }
  }

  network_interface {
    # Ensure it has networking needed
    network    = "default"
    network_ip = each.value.network_ip
    access_config {
    }
  }

  # Upload ssh keys for access
  metadata = {
    ssh-keys = "${var.SSH_USER}:${file("${var.PUBLIC_KEY}")}"
  }
}