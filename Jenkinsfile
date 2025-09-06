pipeline {
    agent any

    // Parameter to pass name
    parameters {
        string(name: 'NAME', defaultValue: 'Mamatha', description: 'Your name to show on the web page')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build HTML page') {
            steps {
                // Create a temporary HTML file
                sh """
                    echo '<html><body>Hello, ${params.NAME}</body></html>' > /tmp/index.html
                """
            }
        }

        stage('Deploy to Nginx') {
            steps {
                sh """
                    # Copy to Nginx directory and restart service
                    sudo cp /tmp/index.html /var/www/html/index.html
                    sudo systemctl restart nginx
                """
            }
        }
    }

    post {
        success {
            // Print public IP of the server
            echo "Open your page at: http://$(curl -s ifconfig.me)/"
        }
        failure {
            echo "Pipeline failed. Check logs for errors."
        }
    }
}
