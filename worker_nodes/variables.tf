variable "kubeadm_token" {
  type = string
}

variable "rg_name" {
  type        = string
  description = "Name of the RG to place resources"
}

variable "location" {
  type        = string
  description = "location of RG"
}

variable "network_interface_ids" {
  type = list(string)
}

variable "id" {
  type = string
}

variable "master_ip" {
  type = string
}

variable "username" {
  type = string
}
