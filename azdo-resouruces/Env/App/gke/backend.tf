terraform {
  backend "gcs" {
    bucket = "mybucket"  
    prefix = "pd/pd-gke"
  }
}
