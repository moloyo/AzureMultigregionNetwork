variable "resource_group_name" {
  type = string
}

variable "kubeadm_token" {
  type = string
}

variable "west_europe_nodes" {
  type = set(string)
}

variable "west_us_nodes" {
  type = set(string)
}

variable "username" {
  type = string
}
