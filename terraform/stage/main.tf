provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source = "../modules/app",
  app_disk_image = "${var.app_disk_image}"
  public_key_path = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
}

module "mongo" {
  source = "../modules/mongo"
  mongo_disk_image = "${var.mongo_disk_image}"
  public_key_path = "${var.public_key_path}"
}

module "vpc" {
  source = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}