provider "google" {
  project     = var.gcp_project_id
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-working-terraform-vm"
  machine_type = "e2-standard-2"


  boot_disk {
    initialize_params {
      image = "projects/ml-images/global/images/c0-deeplearning-common-cpu-v20240128-debian-11-py310"
      size  = 50
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"
    access_config {
      network_tier = "PREMIUM"
    }
  }

 service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

tags = ["http-server", "https-server"]

}