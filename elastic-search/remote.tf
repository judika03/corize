
terraform {
  backend "gcs" {
    bucket  = "staging-tfstates"
    prefix  = "elasticsearch"
  }
}
