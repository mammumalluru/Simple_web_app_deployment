pipeline {
    agent any

    parameters {
        string(name: 'NAME', defaultValue: 'Mamatha', description: 'Your name to show on the web page')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build page') {
            steps {
                sh """
                    # Remove old file if exists
                    sudo rm -f /var/www/html/index.html

                    # Create simple HTML page
                    cat > /var/www/html/index.html <<EOL
<html>
  <body>
    Hello, ${params.NAME}
  </body>
</html>
EOL
                """
            }
        }

        stage('Deploy to Nginx') {
            steps {
                script {
                    sh """
                        if [ -f "/var/www/html/index.html" ]; then
                            echo ":page_facing_up: Found index.html"
                            sudo systemctl restart nginx
                            echo ":white_check_mark: Deployed: Welcome to your web app ${params.NAME}"
                        else
                            echo ":x: index.html not found!"
                            exit 1
                        fi
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Build and deployment successful!"
        }
        failure {
            echo "Build or deployment failed!"
        }
    }
}
