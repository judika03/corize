output "instance" {
  description = "List of self-links for compute instances"
  value       = google_compute_instance.server.name
}
output "ip" {
  value = google_compute_instance.server.network_interface.network
}