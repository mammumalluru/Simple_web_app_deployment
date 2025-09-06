 #!/bin/bash
set -e

# Remove any old Jenkins repo (prevents apt errors)
sudo rm -f /etc/apt/sources.list.d/jenkins.list
sudo rm -f /usr/share/keyrings/jenkins.gpg

# Update system
sudo apt update -y
sudo apt upgrade -y

# Install required packages
sudo apt install -y openjdk-17-jre-headless wget git nginx

# Start and enable Nginx
sudo systemctl enable --now nginx

# Create custom web page
echo "<h1>Welcome to your web app Mamatha</h1>" | sudo tee /var/www/html/index.html
sudo systemctl restart nginx

# Install Jenkins via WAR (bypasses broken repo)
sudo mkdir -p /opt/jenkins
cd /opt/jenkins

# Download latest stable Jenkins WAR
sudo wget https://get.jenkins.io/war-stable/latest/jenkins.war

# Create a systemd service for Jenkins
cat <<EOF | sudo tee /etc/systemd/system/jenkins.service
[Unit]
Description=Jenkins Daemon
After=network.target

[Service]
User=ubuntu
Group=ubuntu
ExecStart=/usr/bin/java -jar /opt/jenkins/jenkins.war
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start Jenkins
sudo systemctl daemon-reload
sudo systemctl enable --now jenkins

# Final message
echo "Jenkins installed via WAR file."
echo "Access Jenkins at: http://$(curl -s ifconfig.me):8080"
echo "To get the initial admin password (generated on first run):"
echo "cat /opt/jenkins/secrets/initialAdminPassword"

