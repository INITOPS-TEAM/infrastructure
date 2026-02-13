pipeline {
    agent any 
    stages {
        stage('Prepare & Check') {
            steps {
                script {
                    echo "Checking if Ansible is ready..."
                    sh 'ansible-playbook --version'
                }
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                dir('ansible') {
                    sshagent(['pictapp-dev-ssh']) {    
                        withCredentials([
                            string(credentialsId: 'flask-secret-key', variable: 'FLASK_SECRET_KEY'), 
                            string(credentialsId: 'db-password', variable: 'DB_PASSWORD'), 
                            aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-access-key-veronika', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')
                        ]){
                            sh '''
                                ansible-playbook -i inventory/dynamic_aws_ec2.yml playbook.yml \
                                -u ubuntu \
                                -e "db_password=${DB_PASSWORD}" \
                                -e "flask_secret_key=${FLASK_SECRET_KEY}" \
                                -vv
                            '''
                        }
                    }    
                }
            }
        }
    }
}