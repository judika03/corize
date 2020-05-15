resource "google_compute_firewall" "fw-rule" {
  name      = var.name
  network   = var.network
  project   = var.project_id
  description = "Creates Firewall rule targetting tagged instances"

  allow {
    protocol = var.protocol
    ports    = ["var.ports"]
  }
  target_tags   = [var.name]
  source_ranges = ["var.source_ranges"]
}
