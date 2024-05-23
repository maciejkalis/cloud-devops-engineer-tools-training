provider "google" {
}
# [START vpc_auto_create]
resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = "my-auto-mode-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}

resource "google_compute_firewall" "rules" {
  project = var.project_id
  name    = "my-firewall-rule"
  network = "vpc_network"
  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }
}