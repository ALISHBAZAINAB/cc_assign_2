# Assignment 2 – Nginx Load Balancer with SSL, Caching & High Availability

## Course
Cloud Computing / DevOps

## Student
Name: __________  
Roll No: __________

---

## Project Overview

This project demonstrates the deployment of an **Nginx Reverse Proxy Load Balancer** on AWS using **Terraform**.  
The setup includes:

- HTTPS with self-signed SSL certificate
- Load balancing between two backend web servers
- Backup server for high availability
- Nginx caching
- Security headers
- HTTP to HTTPS redirection
- Logging and monitoring
- Infrastructure cleanup

---

## Architecture

- **Nginx Load Balancer**
- **Web-1 (Primary)**
- **Web-2 (Primary)**
- **Web-3 (Backup)**

Traffic flow:

Client → Nginx → Web-1 / Web-2  
If both fail → Web-3 (backup)

---

## Technologies Used

- AWS EC2
- Nginx
- Apache (httpd)
- Terraform
- GitHub

---

## SSL Certificate

A self-signed SSL certificate is configured on the Nginx server to enable HTTPS.

📸 Screenshot:  
`screenshots/assignment_part5_ssl_warning.png`

---

## Load Balancing Verification

Traffic alternates between **web-1** and **web-2** on multiple refreshes.  
Backup server does not serve traffic unless primary servers fail.

📸 Screenshots:
- `screenshots/assignment_part5_web1_response.png`
- `screenshots/assignment_part5_web2_response.png`
- `screenshots/assignment_part5_load_balancing_demo.png`

---

## Cache Functionality Test

Nginx caching is verified using response headers.

- First request: `X-Cache-Status: MISS`
- Second request: `X-Cache-Status: HIT`

📸 Screenshots:
- `screenshots/assignment_part5_cache_miss.png`
- `screenshots/assignment_part5_cache_hit.png`
- `screenshots/assignment_part5_cache_directory.png`
- `screenshots/assignment_part5_access_log_cache.png`

---

## High Availability (Backup Server)

Backup server activates when both primary servers are stopped.

Steps:
1. Stop Apache on web-1 → traffic served by web-2
2. Stop Apache on web-2 → backup web-3 activated
3. Restart services → normal load balancing restored

📸 Screenshots:
- `screenshots/assignment_part5_backup_activated.png`
- `screenshots/assignment_part5_nginx_error_log.png`
- `screenshots/assignment_part5_services_restored.png`

---

## Security Features

- HTTPS enabled
- HTTP to HTTPS redirection (301)
- Security headers added:
  - X-Frame-Options
  - X-Content-Type-Options
  - X-XSS-Protection

---

## Logs & Monitoring

- Access logs: `/var/log/nginx/access.log`
- Error logs: `/var/log/nginx/error.log`

Logs were used to verify backend failures and cache behavior.

---

## Repository Notes

- Sensitive files are excluded using `.gitignore`
- `terraform.tfvars.example` provided instead of real tfvars
- No keys or secrets committed

---

## Cleanup

All AWS resources were destroyed after testing to avoid charges.

```bash
terraform destroy
