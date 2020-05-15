output "instance" {
  description = "List of self-links for compute instances"
  value       = google_compute_instance.server.name
}