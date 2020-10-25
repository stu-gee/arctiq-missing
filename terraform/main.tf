// Configure the Google Cloud provider
provider "google" {
  credentials = file("credentials.json")
  project     = "phrasal-planet-293419"
  region      = "us-west1"
  zone        = "us-west1-a"
}

// Configure webserver instance
resource "google_compute_instance" "vm_instance01" {
  name         = "webserver"
  machine_type = "f1-micro"

  tags = ["web"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
  }

  provisioner "remote-exec" {
    inline = ["echo 'Hello World'"]

    connection {
      type        = "ssh"
      user        = "${var.ssh_user}"
      private_key = "${file("${var.private_key_path}")}"
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i '${google_compute_instance.tfansible.network_interface.0.access_config.0.assigned_nat_ip},' --private-key ${var.private_key_path} ../ansible/provisioning/main.yml"
  }

}
