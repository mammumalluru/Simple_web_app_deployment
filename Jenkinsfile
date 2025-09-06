pipeline {
    agent any
    environment {
        NGINX_PATH = '/var/www/html'  // Ubuntu lo Nginx default path
   }
    triggers {
        GenericTrigger(
            genericVariables: [
                [key: 'ref', value: '$.ref']
            ],
            causeString: 'Triggered by GitHub push',
            token: 'deploy-webapp',
            printContributedVariables: true,
            printPostContent: true
        )
    }
    stages {
        stage('Pull Code') {
            steps {
                script {
                    echo ":mag: Pulling latest code..."
                    git branch: 'main',
                         url: 'https://github.com/mammumalluru/Simple_web_app_deployment.git'
                }
            }
        }
    stage('Deploy to Nginx') {
        steps {
            script {
                sh '''
                    if [ -f "index.html" ]; then
                        echo ":page_facing_up: Found index.html"
                        sudo cp index.html /var/www/html/
                        sudo systemctl restart nginx
                        echo ":white_check_mark: Deployed: Welcome to your web app Mamatha"
                    else
                        echo ":x: index.html not found!"
                        exit 1
                    fi
                '''
            }
        }
    }
        stage('Verify Nginx') {
            steps {
                sh 'sudo systemctl is-active --quiet nginx || sudo systemctl start nginx'
            }
        }
    }
    post {
        success {
            echo ":tada: SUCCESS: Deployment completed!"
        }
        failure {
            echo ":x: FAILED: Deployment failed!"
        }
    }
}