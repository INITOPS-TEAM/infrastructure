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
                            string(credentialsId: 'flask-secret-key', variable: 'flask_secret_key'), 
                            string(credentialsId: 'db-password', variable: 'db_password'), 
                            aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-access-key-veronika', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')
                            ]){
                            sh '''
                                export ANSIBLE_DB_PASSWORD="${db_password}"
                                export ANSIBLE_FLASK_SECRET_KEY="${flask_secret_key}"
                                ansible-playbook -i inventory/dynamic_aws_ec2.yml playbook.yml -u ubuntu -vv
                            '''
                        }
                    }    
                }
            }
        }
    }
}
