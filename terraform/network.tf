# Сеть для нашей инфраструктуры

resource "yandex_vpc_network" "project_net" {
  name = "my_net"
}

# Подсеть в регионе а 

resource "yandex_vpc_subnet" "project_a" {
  name           = "my_subnet_ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.project_net.id
  v4_cidr_blocks = ["10.0.1.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

# Подсеть в регионе b 

resource "yandex_vpc_subnet" "project_b" {
  name           = "my_subnet_ru-central1-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.project_net.id
  v4_cidr_blocks = ["10.0.2.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

# Шлюз для выхода в интернет

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "gateway"
  shared_egress_gateway {}
}

# Сетевой маршрут для выхода в интернет через шлюз

resource "yandex_vpc_route_table" "rt" {
  name       = "my-route-table"
  network_id = yandex_vpc_network.project_net.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}











