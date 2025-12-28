variable "vpc_id" {
  type        = string
  description = "VPC ID to attach security groups"
}

variable "env_prefix" {
  type        = string
  description = "Environment prefix for naming resources"
}

variable "my_ip" {
  type        = string
  description = "Your public IP for SSH access"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for all resources"
}
