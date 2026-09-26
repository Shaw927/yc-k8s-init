data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "k8s_vm" {
  name        = var.vm_name
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.boot_disk_size
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.k8s_subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.k8s_sg.id]
  }

  metadata = {
    ssh-keys  = "ubuntu:${file(var.ssh_public_key_path)}"
    user-data = file("${path.module}/cloud-init.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}
