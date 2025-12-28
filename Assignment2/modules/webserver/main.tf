# Key pair for all instances
resource "aws_key_pair" "assignment2" {
  key_name   = "assignment2-key"
  public_key = file(var.public_key)
}

# Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# Backend servers
resource "aws_instance" "backend" {
  for_each = { for srv in var.backend_servers : srv.name => srv }

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.backend_sg_id]
  key_name               = aws_key_pair.assignment2.key_name
  private_ip             = each.value.private_ip
  user_data              = file(var.backend_script_path)

  tags = {
    Name = each.key
  }
}

# Nginx proxy server
resource "aws_instance" "nginx" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.nginx_sg_id]
  key_name               = aws_key_pair.assignment2.key_name
  private_ip             = var.nginx_private_ip
  user_data              = file(var.nginx_script_path)

  tags = {
    Name = "prod-nginx-proxy"
  }
}
