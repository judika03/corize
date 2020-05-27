
data "google_service_account" "service_account" {
    account_id = "gitlab-ci"
    project = var.project_id
}

module "instance_template-es-master" {
  source               = "github.com/judika03/module-terraform/modules/instance_template"
  region               = var.region
  project_id = var.project_id
  subnetwork           = var.subnetwork
  machine_type         =var.master_machine_type
  subnetwork_project    = var.project_id
  email                = data.google_service_account.service_account.email
  startup_script=data.template_file.instance_startup_script.rendered
}

module "instance_template-es-data" {
  source               = "github.com/judika03/module-terraform/modules/instance_template"
  region               = var.region
  project_id = var.project_id
  machine_type         =var.master_machine_type
  subnetwork           = var.subnetwork
 subnetwork_project     = var.project_id
  email                = data.google_service_account.service_account.email
  startup_script=data.template_file.instance_startup_script1.rendered
}

module "managed_instance_group-master" {
  source            = "github.com/judika03/module-terraform/modules/manager_instance_group"
  region            = var.region
  project_id = var.project_id

  target_size       = 1
  hostname          = "test-elastic-master-spid"
  instance_template = module.instance_template-es-master.self_link
  named_ports = [{
    name = "elasticsearch"
    port = 9200
  }]
}

module "managed_instance_group-data" {
  source            = "github.com/judika03/module-terraform/modules/manager_instance_group"
  region            = var.region
  project_id = var.project_id
  target_size       = var.num_instance_master
  hostname          = "test-elastic-data-spid"
  instance_template = module.instance_template-es-data.self_link
  named_ports = [{
    name = "elasticsearch"
    port = 9200
  }]
}

module "gce-ilb" {
  source       = "github.com/judika03/module-terraform/modules/lb-internal"
  project      = var.project_id
  network      = var.network
  subnetwork   = var.subnetwork
  region       = var.region
  name         = "test-elastic-lb-terraform"
  health_check = local.health_check
  source_tags  = ["allow-group1"]
  ports        = ["9200"]
  target_tags  = ["allow-lb-service"]
    backends = [
    {
      group       = module.managed_instance_group-master.instance_group
      description = ""
    },
    {
      group       = module.managed_instance_group-data.instance_group
      description = ""
    },
  ]
}
  
