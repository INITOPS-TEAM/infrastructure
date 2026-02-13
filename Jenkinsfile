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
                dir('/ansible') {
                    sh 'ansible-playbook -i inventory/hosts.ini playbook.yml'
                }
            }
        }
    }
}
