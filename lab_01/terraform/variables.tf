variable "region" {
  type    = string
}

variable "owner" {
  type    = string
}

variable "key_name" {
  type    = string
}

variable "ec2_config" {
  type = object({
    ami                   = string
    instance_type         = string
    name                  = string
  })
}
