module "service_accounts" {
  source        = "github.com/judika03/module-terraform/modules/service_account"
  project_id    = var.project_id
  prefix        = var.prefix
  names         = ["elastic-test"]
  project_roles = ["${var.project_id}=>roles/viewer","${var.project_id}=>roles/compute.admin",
]
}
