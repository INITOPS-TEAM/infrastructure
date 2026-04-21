pipeline {
    agent any
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'stage', 'prod'], description: 'Choose deploy environment')
    }
    stages {
        stage('Prepare & Check') {
            steps {
                script {
                    echo "Checking if Ansible is ready..."
                    sh 'ansible-playbook --version'
                }
            }
        }

	stage('Approve Production') {
            when {
                expression { return params.ENVIRONMENT == 'prod' }
            }
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    input message: "Deploy to PRODUCTION. Continue?", ok: 'Yes, deploy'
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
                        ]){
                            sh """
			    	echo "Starting deployment to the environment: ${params.ENVIRONMENT}"
                                ansible-playbook -i inventory/dynamic_aws_ec2.yml playbook.yml \
                                -u ubuntu \
				--limit "tag_Environment_${params.ENVIRONMENT}" \
                                -e "db_password=${DB_PASSWORD}" \
                                -e "flask_secret_key=${FLASK_SECRET_KEY}" \
                                -v
                            """
                        }
                    }    
                }
            }
        }
    }
}
