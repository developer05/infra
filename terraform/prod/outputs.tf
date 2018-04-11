output "app_external_ip" {
  value = "${module.app.external_ip}"
}

output "mongo_external_ip" {
  value = "${module.mongo.external_ip}"
}
