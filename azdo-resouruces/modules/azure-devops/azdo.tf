## Create resources for Azure DevOps

data "google_client_config" "current" {
}

data "azuredevops_project" "azdo_project" {
  name = var.azdo_project_name
}

data "google_container_cluster" "primary" {
  name     = "mycluster"
  location = "us-east1"
  project  = "myproject"
}

provider "azuredevops" {
  alias                 = "azdo"
  org_service_url       = var.AZDO_ORG_SERVICE_URL
  personal_access_token = var.AZDO_PERSONAL_ACCESS_TOKEN
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

## Create namespace
resource "kubernetes_namespace" "namespaces" {
  for_each = toset(var.namespaces)
  metadata {
    name = each.key
  }
}

## Create k8s secret
resource "kubernetes_secret" "k8s_secrets" {
  for_each = resource.kubernetes_namespace.namespaces
  metadata {
    name      = "${each.key}-secret"
    namespace = each.key
    annotations = {
      "kubernetes.io/service-account.name" = "${each.key}-svc-acc"
    }
  }
  type = var.secret_type
}

## Create service account
resource "kubernetes_service_account" "svc-acc" {
  for_each = resource.kubernetes_namespace.namespaces
  metadata {
    name      = "${each.key}-svc-acc"
    namespace = each.key
  }
  secret {
    name = "${each.key}-secret"
  }
  depends_on = [
    resource.kubernetes_secret.k8s_secrets
  ]
}

## Create the cluster role binding
resource "kubernetes_cluster_role_binding" "role_binding" {
  for_each = kubernetes_service_account.svc-acc
  metadata {
    #name = kubernetes_service_account.svc-acc.metadata.0.name
    name = "${each.key}-svc-acc"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = "admin"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "kube-system"
  }
  subject {
    kind      = "Group"
    name      = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }
  dynamic "subject" {
    for_each = resource.kubernetes_namespace.namespaces
    content {
      kind      = "ServiceAccount"
      name      = "${each.key}-svc-acc"
      namespace = each.key
    }
  }
  depends_on = [
    resource.kubernetes_secret.k8s_secrets
  ]
}

## Create a service connection
resource "azuredevops_serviceendpoint_kubernetes" "svc_conn" {
  project_id            = data.azuredevops_project.azdo_project.id
  service_endpoint_name = "test-sc"
  apiserver_url         = "https://${data.google_container_cluster.primary.endpoint}"
  authorization_type    = "ServiceAccount"

  service_account {
    token   = "test"
    ca_cert = "test"
  }
}
