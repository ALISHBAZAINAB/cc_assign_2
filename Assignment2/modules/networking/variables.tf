variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "nginx_security_group_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "script_path" {
  type    = string
  default = "scripts/apache-setup.sh"
}

variable "nginx_script_path" {
  type    = string
  default = "scripts/nginx-setup.sh"
}
