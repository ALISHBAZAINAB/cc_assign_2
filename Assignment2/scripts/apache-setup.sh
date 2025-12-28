
#!/bin/bash
set -e

yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd

TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
PRIVATE_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/public-ipv4)
HOSTNAME=$(hostname)

cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
<title>Backend Web Server</title>
<style>
body { font-family: Arial; margin:50px; background:linear-gradient(135deg,#667eea 0%,#764ba2 100%); color:white; }
.container { background: rgba(255,255,255,0.1); padding:30px; border-radius:10px; }
h1 { color:#fff; }
.info { margin:15px 0; padding:10px; background:rgba(255,255,255,0.2); border-radius:5px; }
.label { font-weight:bold; color:#ffd700; }
</style>
</head>
<body>
<div class="container">
<h1>🚀 Backend Web Server</h1>
<div class="info"><span class="label">Hostname:</span> $HOSTNAME</div>
<div class="info"><span class="label">Private IP:</span> $PRIVATE_IP</div>
<div class="info"><span class="label">Public IP:</span> $PUBLIC_IP</div>
<div class="info"><span class="label">Status:</span> ✅ Active and Running</div>
</div>
</body>
</html>
EOF

chmod 644 /var/www/html/index.html
systemctl restart httpd
echo "Apache setup completed!"
