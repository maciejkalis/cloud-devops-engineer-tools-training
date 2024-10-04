terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.32.0"
    }
  }
}

provider "google" {
  # Configuration options
}

resource "google_compute_instance" "Dev_VM" {
  count = 3
  name  = "dev_VM${count.index + 1}"
  machine_type = "n2-standard-2"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
}

resource "google_compute_instance" "dev_VM" {
  for_each = toset(["us-central-1", "asia-east1-b", "europe-west4-a"])
  name = "dev-${each.value}"
  zone = each.value
  machine_type = "n2-standard-2"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }  
}