provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "app" {
  name         = "catalog-app"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"
  tags = ["catalog-app"]

  "boot_disk" {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  "network_interface" {
    network       = "default"
    access_config = {}
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
    source      = "files/catalog.service"
    destination = "/tmp/catalog.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
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
