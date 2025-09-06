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
                    rm -f /var/www/html/index.html

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
                //  just restart Nginx
                sh 'sudo systemctl restart nginx'
            }
    }
  }


    post {
        success {
            echo "Open: http://$(curl -s ifconfig.me)/"
        }
    }
}


