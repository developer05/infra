resource "google_compute_instance" "mongo" {
  name = "catalog-db"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"
  tags = ["catalog-db"]

  "boot_disk" {
    initialize_params {
      image = "${var.mongo_disk_image}"
    }
  }

  "network_interface" {
    network = "default"
    access_config {}
  }

  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_mongo" {
  name = "allow-mongo-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["27017"]
  }

  # правило применимо к инстансам с тегом
  target_tags = ["catalog-db"]

  # порт будет доступен только для инстансов с тегом
  source_tags = ["catalog-app"]
}