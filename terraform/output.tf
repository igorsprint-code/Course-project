output "bastion_pub_ip" {
  value =  yandex_compute_instance.bastion.network_interface.0.nat_ip_address
  
}

output "bastion_ip" {
  value =  yandex_compute_instance.bastion.network_interface.0.ip_address
}

output "web_1" {
  value =  yandex_compute_instance.web_1.network_interface.0.ip_address
}


output "web_2" {
  value =  yandex_compute_instance.web_2.network_interface.0.ip_address
}

output "prometheus" {
  value =  yandex_compute_instance.prometheus_vm.network_interface.0.ip_address
}

output "grafana" {
  value =  yandex_compute_instance.grafana_vm.network_interface.0.ip_address
}

output "grafana_pub" {
  value =  yandex_compute_instance.grafana_vm.network_interface.0.nat_ip_address
}

output "elasticsearch" {
  value =  yandex_compute_instance.elasticsearch_vm.network_interface.0.ip_address
}

output "kibana_pub" {
  value =  yandex_compute_instance.kibana_vm.network_interface.0.nat_ip_address
}

output "kibana" {
  value =  yandex_compute_instance.kibana_vm.network_interface.0.ip_address
}

