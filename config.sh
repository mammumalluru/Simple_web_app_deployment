# user_data = <<-EOF
#     #!/bin/bash
#     set -eux

#     apt-get update -y
#     apt-get install -y openjdk-17-jdk gnupg2 curl git nginx

#     # Jenkins repo
#     curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
#     echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/' \
#       | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

#     apt-get update -y
#     apt-get install -y jenkins

#     systemctl enable --now jenkins
#     systemctl enable --now nginx

#     # Allow Jenkins to deploy html via sudo cp
#     echo 'jenkins ALL=(ALL) NOPASSWD: /usr/bin/cp' > /etc/sudoers.d/jenkins
#     chmod 440 /etc/sudoers.d/jenkins

#     # Default page (later Jenkins will overwrite)
#     echo "<h1>Hello from Nginx on Ubuntu</h1>" > /var/www/html/index.html
#   EOF

#   tags = {
#     Name = "jenkins-demo"
#   }

#   }


  !/bin/bash
# :white_check_mark: 100% Working Script for Ubuntu 22.04 LTS
# Installs: Nginx, Java 17, Jenkins, Git
# Web Page: "Welcome to your web app Linganna"
# Jenkins runs on Java 17 (required for Jenkins 2.526+)
set -e  # Exit on any error
echo ":rocket: Starting setup on Ubuntu 22.04 LTS..."
# Update system
echo ":arrows_counterclockwise: Updating package index..."
apt update -y
# Install Nginx
echo ":package: Installing Nginx..."
apt install -y nginx
systemctl start nginx
systemctl enable nginx
# Create custom web page
echo ":page_facing_up: Creating custom web page..."
echo "<h1>Welcome to your web app Linganna</h1>" > /var/www/html/index.html
systemctl restart nginx
# Install Java 17 (required for Jenkins 2.526)
echo ":gear: Installing OpenJDK 17..."
apt install -y openjdk-17-jre-headless
# Verify Java version
java -version
# Add Jenkins repository key
echo ":closed_lock_with_key: Adding Jenkins GPG key..."
mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
# Add Jenkins repository
echo ":link: Adding Jenkins repository..."
echo "deb [signed-by=/usr/share/keyrings/jenkins.gpg] https://pkg.jenkins.io/debian binary/" | tee /etc/apt/sources.list.d/jenkins.list > /dev/null
# Update package list
echo ":arrows_counterclockwise: Updating package list..."
apt update -y
# Install Jenkins
echo ":inbox_tray: Installing Jenkins..."
apt install -y jenkins
# Fix permissions (critical)
echo ":shield: Fixing Jenkins directory permissions..."
chown -R jenkins:jenkins /var/lib/jenkins
chmod 755 /var/lib/jenkins
# Reload systemd and start Jenkins
echo ":arrows_counterclockwise: Starting Jenkins..."
systemctl daemon-reload
systemctl enable jenkins --now
# Install Git
apt install -y git
# Final success message
echo ":white_check_mark: SUCCESS: Setup completed!"
echo ":globe_with_meridians: Nginx: http://<your-ip>"
echo ":wrench: Jenkins: http://<your-ip>:8080"
echo ":key: Get Jenkins password: sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
