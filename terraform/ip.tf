resource "local_file" "pub_ip" {
  content  = <<-XYZ
  [bastion]
  ${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}

  
  [grafana_server]
  ${yandex_compute_instance.grafana_vm.network_interface.0.nat_ip_address}
  
 


  [kibana_server]
  ${yandex_compute_instance.kibana_vm.network_interface.0.nat_ip_address}
 
  XYZ
  filename = "../pub_ip.txt"
}