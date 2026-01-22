provider "google" {
  project = var.project_id
}

resource "google_storage_bucket" "example" {
  name          = "${var.project_id}-tf-example-bucket"
  location      = "US"
  force_destroy = true
}
