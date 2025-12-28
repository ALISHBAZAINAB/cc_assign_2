module "backend_servers" {
  source           = "./modules/webserver"
  servers          = var.backend_servers
  subnet_id        = var.subnet_id
  security_group_id = var.backend_sg_id
  instance_type    = var.instance_type
  env_prefix       = var.env_prefix
  key_name         = aws_key_pair.assignment2.key_name
  common_tags      = var.common_tags
}

module "nginx_server" {
  source           = "./modules/webserver"
  servers          = [{ name = "nginx", script_path = var.nginx_script_path }]
  subnet_id        = var.subnet_id
  security_group_id = var.nginx_sg_id
  instance_type    = var.instance_type
  env_prefix       = var.env_prefix
  key_name         = aws_key_pair.assignment2.key_name
  common_tags      = var.common_tags
}

resource "aws_key_pair" "assignment2" {
  key_name   = "${var.env_prefix}-assignment2-key"
  public_key = file(var.public_key)
}
