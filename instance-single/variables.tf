####################
# network_interface
####################
variable "network" {
  description = "The name or self_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks."
  default     = "default"
}

variable "subnetwork" {
  description = "The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided."
  default     = "default"
}

variable "network_ip" {
  default     = ""
}

variable "zone" {
  type = string
  default = "asia-southeast1-a" 
}
variable "project_id" {
  type        = string
  
}

variable "email" {
    default=""
}

variable "firewall_count" {
  description = "The number of read replicas to create. Cloud SQL will replicate all data from the master to these replicas, which you can use to horizontally scale read traffic."
    type = list(object({
    project   = string
    name      = string
    network   = string
  }))
  default = []
}

variable "name_instance" {
  description = "The GCP project to use for integration tests"
  type        = string
}

variable "region" {
  description = "The GCP region to create and test resources in"
  type        = string
  default     = "asia-southeast1"
}
variable "machine_type" {
  description = "Machine type to create, e.g. n1-standard-1"
  default     = "n1-standard-1"
}
variable "startup_script" {
  description = "User startup script to run when instances spin up"
  default     = ""
}

variable "service_account" {
  description = "The GCP project to use for integration tests"
    default     = ""
}

variable "ports" {
type        = list(string)
default     = []
}
variable "tags" {
type        = list(string)
description = "Network tags, provided as a list"
default     = []
}

variable "name-firewall" {
type      = string
default   = "testing"

}
variable "source_ranges" {
   type = list
   default     = ["0.0.0.0/0"]
  
}
