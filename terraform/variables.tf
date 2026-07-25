variable "cloud_id" {
  type    = string
  default = "b1gegppm1o1298udt1sl"
}
variable "folder_id" {
  type    = string
  default = "b1gjpour80p6sceb8911"
}

variable "ssh_public_key" {
  description = "Public SSH key"
  type        = string
}


variable "admin_ip" {
  type          = string
  default       = "5.18.149.32/32"
}