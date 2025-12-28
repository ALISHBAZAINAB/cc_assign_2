variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "backend_sg_id" {
  type = string
}

variable "nginx_sg_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "public_key" {
  type = string
}

variable "backend_script_path" {
  type = string
}

variable "nginx_script_path" {
  type = string
}

variable "backend_servers" {
  type = list(object({
    name        = string
    private_ip  = string
    public_ip   = string
  }))
}

variable "nginx_private_ip" {
  type = string
}

variable "nginx_public_ip" {
  type = string
}
