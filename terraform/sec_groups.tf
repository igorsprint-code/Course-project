# Группы безопасности(firewall)


# FW для бастион-сервера

resource "yandex_vpc_security_group" "bastion" {
  name       = "bastion"
  network_id = yandex_vpc_network.project_net.id
  ingress {
    description    = "Allow 0.0.0.0/0"
    protocol       = "TCP"
    v4_cidr_blocks = [var.admin_ip]
    port           = 22
  }
  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

}


# FW для web серверов

resource "yandex_vpc_security_group" "web_fw" {
  name       = "web_fw"
  network_id = yandex_vpc_network.project_net.id


  ingress {
    description    = "Allow HTTPS from alb"
    protocol       = "TCP"
    port           = 443
    security_group_id = yandex_vpc_security_group.alb_sg.id 
  }
  ingress {
    description    = "Allow HTTP from alb"
    protocol       = "TCP"
    port           = 80
    security_group_id = yandex_vpc_security_group.alb_sg.id 
  }
  ingress {
    description    = "Allow health alb"
    protocol       = "TCP"
    port           = 80
    predefined_target = "loadbalancer_healthchecks" 
  }
  ingress {
    description    = "Allow ssh"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["${yandex_compute_instance.bastion.network_interface.0.ip_address}/32"]
  }
  ingress {
    description    = "Allow log exporter"
    protocol       = "TCP"
    port           = 4040
    v4_cidr_blocks = ["${yandex_compute_instance.prometheus_vm.network_interface.0.ip_address}/32"]
  }
  ingress {
    description    = "Allow node exporter"
    protocol       = "TCP"
    port           = 9100
    v4_cidr_blocks = ["${yandex_compute_instance.prometheus_vm.network_interface.0.ip_address}/32"]
  }
  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }


}


# FW для Prometheus

resource "yandex_vpc_security_group" "prometheus" {
  name       = "prometheus_vm"
  network_id = yandex_vpc_network.project_net.id
  ingress {
    description    = "Allow 0.0.0.0/0"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.0.0/8"]
    port           = 9090
  }
  ingress {
    description    = "Allow ssh"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["10.0.0.0/8"]
  }
  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

}


# FW для Grafana

resource "yandex_vpc_security_group" "grafana" {
  name       = "grafana_vm"
  network_id = yandex_vpc_network.project_net.id
  ingress {
    description    = "Allow 0.0.0.0/0"
    protocol       = "TCP"
    v4_cidr_blocks = [var.admin_ip]
    port           = 3000
  }
  ingress {
    description    = "Allow ssh"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["10.0.0.0/8"]
  }

  
  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

}

# FW для Elasticsearch

resource "yandex_vpc_security_group" "elasticsearch" {
  name       = "elasticsearch_vm"
  network_id = yandex_vpc_network.project_net.id
  ingress {
    description    = "Allow 0.0.0.0/0"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.0.0/8"]
    port           = 9200
  }
  ingress {
    description    = "Allow ssh"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["10.0.0.0/8"]
  }
  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

}

# FW для Kibana

resource "yandex_vpc_security_group" "kibana" {
  name       = "kibana_vm"
  network_id = yandex_vpc_network.project_net.id
  ingress {
    description    = "Allow 0.0.0.0/0"
    protocol       = "TCP"
    v4_cidr_blocks = [var.admin_ip]
    port           = 5601
  }
  ingress {
    description    = "Allow ssh"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["10.0.0.0/8"]
  }
  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

}


# FW для alb

resource "yandex_vpc_security_group" "alb_sg" {
  name       = "alb_security_group"
  network_id = yandex_vpc_network.project_net.id
  ingress {
    description    = "Allow 0.0.0.0/0"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

}


