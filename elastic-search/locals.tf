
locals {
  health_check = {
    type                = "http"
    check_interval_sec  = 1
    healthy_threshold   = 4
    timeout_sec         = 1
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 9200
    port_name           = "health-elastic-port"
    request             = ""
    request_path        = "/"
    host                = ""
  }
}