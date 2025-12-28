output "backend_servers_info" {
  value = { for name, srv in aws_instance.backend : name => {
    public_ip  = srv.public_ip
    private_ip = srv.private_ip
    instance_id = srv.id
  }}
}

output "nginx_server_info" {
  value = {
    public_ip  = aws_instance.nginx.public_ip
    private_ip = aws_instance.nginx.private_ip
    instance_id = aws_instance.nginx.id
  }
}

output "configuration_guide" {
  value = <<EOT
1. SSH into Nginx proxy: ssh -i ~/.ssh/assignment2.pem ec2-user@${aws_instance.nginx.public_ip}
2. Edit Nginx config: sudo vim /etc/nginx/nginx.conf
3. Update backend IPs in upstream block:
   - BACKEND_IP_1: ${aws_instance.backend["prod-web-1"].private_ip}
   - BACKEND_IP_2: ${aws_instance.backend["prod-web-2"].private_ip}
   - BACKEND_IP_3: ${aws_instance.backend["prod-web-3"].private_ip}
4. Restart Nginx: sudo systemctl restart nginx
5. Test: https://${aws_instance.nginx.public_ip}
EOT
}
