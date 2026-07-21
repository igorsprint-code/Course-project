resource "yandex_compute_snapshot_schedule" "project" {
  schedule_policy {
    expression = "0 10 * * *"
    
  }

  retention_period = "168h"
    

  

  disk_ids = [yandex_compute_instance.bastion.boot_disk.0.disk_id,
  yandex_compute_instance.web_1.boot_disk.0.disk_id,
  yandex_compute_instance.web_2.boot_disk.0.disk_id,
  yandex_compute_instance.prometheus_vm.boot_disk.0.disk_id,
  yandex_compute_instance.grafana_vm.boot_disk.0.disk_id,
  yandex_compute_instance.elasticsearch_vm.boot_disk.0.disk_id,
  yandex_compute_instance.kibana_vm.boot_disk.0.disk_id,
  ]
}