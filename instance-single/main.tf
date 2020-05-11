
resource "google_compute_instance" "server" {
  name         = var.name_instance
  machine_type = var.machine_type
  project = var.project_id
  zone         = var.zone
  tags         = var.tags
  allow_stopping_for_update = true
  metadata_startup_script = var.startup_script

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
service_account {
    email  = var.email
    scopes = ["cloud-platform","compute-rw"]
  }
 network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    subnetwork_project = var.project_id
  }
}



