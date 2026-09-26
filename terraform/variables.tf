variable "yc_token" {
  description = "IAM или OAuth токен Yandex Cloud"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "ID облака"
  type        = string
}

variable "yc_folder_id" {
  description = "ID каталога (folder)"
  type        = string
}

variable "yc_zone" {
  description = "Зона доступности"
  type        = string
  default     = "ru-central1-a"
}

variable "vm_name" {
  description = "Имя ВМ"
  type        = string
  default     = "k8s-lab"
}

variable "vm_cores" {
  type    = number
  default = 2
}

variable "vm_memory" {
  type    = number
  default = 4
}

variable "vm_core_fraction" {
  description = "Гарантированная доля vCPU (20/50/100). 100 - без ограничений, дороже"
  type        = number
  default     = 100
}

variable "boot_disk_size" {
  description = "Размер диска в ГБ"
  type        = number
  default     = 30
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}
