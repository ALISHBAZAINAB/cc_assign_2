variable "servers"          { type = list(object({ name = string, script_path = string })) }
variable "subnet_id"        { type = string }
variable "security_group_id"{ type = string }
variable "instance_type"    { type = string }
variable "env_prefix"       { type = string }
variable "key_name"         { type = string }
variable "common_tags"      { type = map(string) }
