variable "location" { 
    description = "region azure"
    default = "West Europe"
}

variable "tags" {
    description = "tags"
    type = map(string)
    default = {
        "Exploitation": "CCE"
        "Env": "poc"
        "Branch": "TGITS"
        "Appname": "Azure Cloud Infra"
    }
}