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
    ami                         = string
    instance_type               = string
    ssh_key_name                = string
    name                        = string
    associate_public_ip_address = bool
  })
}