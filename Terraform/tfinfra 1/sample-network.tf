# Creating the sample-network network
resource "google_compute_network" "sample-network" {
  name = "sample-network"
  # RESOURCE properties
  auto_create_subnetworks = true
}
# Adding a firewall rule to allow HTTP, SSH, RDP and ICMP traffic on sample-network
resource "google_compute_firewall" "sample-network-allow-http-ssh-rdp-icmp" {
  name = "sample-network-allow-http-ssh-rdp-icmp"
  # RESOURCE properties
  network = google_compute_network.sample-network.self_link
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}
# Creating the sample-us-vm instance
module "sample-us-vm" {
  source           = "./instance"
  instance_name    = "sample-us-vm"
  instance_zone    = "us-central1-c"
  instance_network = google_compute_network.sample-network.self_link
}
# Creating the sample-eu-vm" instance
module "sample-eu-vm" {
  source           = "./instance"
  instance_name    = "sample-eu-vm"
  instance_zone    = "europe-west1-d"
  instance_network = google_compute_network.sample-network.self_link
}