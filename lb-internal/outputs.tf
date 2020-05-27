output "ip_address" {
  description = "The internal IP assigned to the regional forwarding rule."
  value       = google_compute_forwarding_rule.default.ip_address
}
output "instance-group" {
  description = "The instance group assigned to the regional forwarding rule."
  value       = data.google_compute_instance_group.ig.*.self_link 
}

