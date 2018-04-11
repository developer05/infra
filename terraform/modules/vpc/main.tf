resource "google_compute_firewall" "firewall_ssh" {
  name = "all-allow-ssh"
  network = "default"
  source_ranges = "${var.source_ranges}"
  priority = 1000

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}