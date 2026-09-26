resource "yandex_vpc_network" "k8s_net" {
  name = "k8s-lab-net"
}

resource "yandex_vpc_subnet" "k8s_subnet" {
  name           = "k8s-lab-subnet"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.k8s_net.id
  v4_cidr_blocks = ["10.20.0.0/24"]
}

resource "yandex_vpc_security_group" "k8s_sg" {
  name       = "k8s-lab-sg"
  network_id = yandex_vpc_network.k8s_net.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Kubernetes API / NodePort / общий доступ внутри лабы"
    from_port      = 1
    to_port        = 65535
    v4_cidr_blocks = ["10.20.0.0/24"]
  }

  egress {
    protocol       = "ANY"
    description    = "Весь исходящий трафик"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
