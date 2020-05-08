terraform {
  backend "gcs" {
    bucket  = "staging-tfstates"
    prefix  = "database-sql"
  }
}
