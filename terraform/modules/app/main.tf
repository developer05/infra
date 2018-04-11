resource "google_compute_instance" "app" {
  name         = "catalog-app"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"
  tags = ["catalog-app"]

  "boot_disk" {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  "network_interface" {
    network       = "default"
    access_config = {
      nat_ip = "${google_compute_address.catalog_app_ip.address}"
    }
  }

  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "${path.module}/files/catalog.service"
    destination = "/tmp/catalog.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_catalog" {
  name    = "allow-catalog-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["catalog-app"]
}

resource "google_compute_address" "catalog_app_ip" {
  name = "catalog-app-ip"
}