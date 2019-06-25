variable "location" {
  description = "region azure"
  default     = "West Europe"
}

variable "tags" {
  description = "tags"
  type        = map(string)
  default = {
    "Exploitation" : "CCE"
    "Env" : "poc"
    "Branch" : "TGITS"
    "Appname" : "Azure Cloud Infra"
  }
}

variable "subnet_names" {
  description = "noms des subnets"
  type        = list(string)
}

variable "subnet_address_prefix" {
  description = "adressage des subnets"
  type        = list(string)
}