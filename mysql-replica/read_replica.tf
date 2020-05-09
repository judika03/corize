
resource "google_sql_database_instance" "replicas" {
  count                = var.read_replica_size
  project              = var.project_id
  name                 = "${var.name}-replica${count.index}"
  database_version     = var.engine
  region               = var.region
  master_instance_name = google_sql_database_instance.master.name
  
  settings {
    tier              = var.read_replica_tier
    activation_policy = var.read_replica_activation_policy
       ip_configuration {
      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.value
        }
      }

      ipv4_enabled    = var.enable_public_internet_access
      private_network =  data.google_compute_network.my-network.self_link
      require_ssl     = var.require_ssl
    }
    crash_safe_replication = var.read_replica_crash_safe_replication
    disk_autoresize        = var.read_replica_disk_autoresize
    disk_size              = var.rdisk_size
    disk_type              = var.disk_type
    pricing_plan           = var.read_replica_pricing_plan
    replication_type       = var.read_replica_replication_type
    user_labels            = var.read_replica_user_labels
    dynamic "database_flags" {
      for_each = var.read_replica_database_flags
      content {
        name  = lookup(database_flags.value, "name", null)
        value = lookup(database_flags.value, "value", null)
      }
    }

    maintenance_window {
      day          = var.maintenance_window_day
      hour         = var.maintenance_window_hour
      update_track = var.read_replica_maintenance_window_update_track
    }
  }

  depends_on = [google_sql_database_instance.master]

  lifecycle {
    ignore_changes = [
      settings[0].disk_size
    ]
  }

  timeouts {
    create = var.resource_timeout
    update = var.resource_timeout
    delete = var.resource_timeout
  }
}


