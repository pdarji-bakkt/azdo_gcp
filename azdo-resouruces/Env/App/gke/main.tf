module "gke-cluster" {
## removed code
}

# Azure Devops resources
module "azure-devops" {
  source                     = "../../../../modules/azure-devops" ## path is correct on my original code, changed folder structure while uploading to public
  namespaces                 = var.namespaces
  AZDO_PERSONAL_ACCESS_TOKEN = var.AZDO_PERSONAL_ACCESS_TOKEN
}

/********************************************
GKE Shared VPC Firewall Custom Role Creation.
********************************************/
resource "google_project_iam_custom_role" "fw_rule" {
## removed code
}

/******************************************************
GKE Shared VPC Firewall Custom Role Project IAM Mapping
******************************************************/
data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_iam_member" "my_project" {
## removed code
}
