# Configure the Google Cloud provider
provider "google" {
  credentials = file("credentials.json")
  project     = var.PROJECT
  region      = var.REGION
  zone        = var.ZONE
}