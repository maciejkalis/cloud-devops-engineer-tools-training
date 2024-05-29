terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.31.1"
    }
  }
}

provider "google" {
  # Configuration options
}

resource "google_compute_instance" "my-instance" {
  count        = 2
  
  name         = "test"
  machine_type = "e2-micro"
  network_interface {
    network = "default"
  }
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }  
}