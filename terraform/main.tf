# Configure the Google Cloud provider
provider "google" {
  credentials = file("credentials.json")
  project     = "phrasal-planet-293419"
  region      = "us-west1"
  zone        = "us-west1-a"
}

# Configure appserver instance
resource "google_compute_instance" "appserver" {
  name         = "appserver"
  machine_type = "e2-standard-4"

  # Tag it for assigning
  tags = ["app"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    # Ensure it has a static IP address
    network = "default"
    network_ip = "10.138.0.44"
    access_config {
      nat_ip = google_compute_address.appserver.address
    }
  }

  # Upload ssh keys for access
  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
  }

  # Confirm system is up and responsive
  provisioner "remote-exec" {
    inline = ["echo 'System Ready'"]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("${var.private_key_path}")
      host        = google_compute_instance.appserver.network_interface.0.access_config.0.nat_ip
    }
  }

  # Run ansible-playbook against system
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.ssh_user}@'${google_compute_instance.appserver.network_interface.0.access_config.0.nat_ip},' --private-key ${var.private_key_path} ../ansible/provisioning/appserver/main.yml"
  }

}

# Configure webserver instance
resource "google_compute_instance" "webserver" {
  name         = "webserver"
  machine_type = "e2-standard-4"

  # Tag it for assigning
  tags = ["web"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    # Ensure it has a static IP address
    network = "default"
    network_ip = "10.138.0.45"
    access_config {
      nat_ip = google_compute_address.webserver.address
    }
  }

  # Upload ssh keys for access
  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
  }

  # Confirm system is up and responsive
  provisioner "remote-exec" {
    inline = ["echo 'System Ready'"]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("${var.private_key_path}")
      host        = google_compute_instance.webserver.network_interface.0.access_config.0.nat_ip
    }
  }

  # Run ansible-playbook against system
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.ssh_user}@'${google_compute_instance.webserver.network_interface.0.access_config.0.nat_ip},' --private-key ${var.private_key_path} ../ansible/provisioning/webserver/main.yml"
  }

}
