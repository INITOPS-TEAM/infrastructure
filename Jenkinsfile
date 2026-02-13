pipeline {
    agent any 

    stages {
        // stage('Checkout') {
        //     steps {
        //         git 'https://github.com/INITOPS-TEAM/infrastructure.git'
        //     }
        // }
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
                    sh 'ansible-playbook -i inventory/dynamic_ec2.yml playbook.yml'
                }
            }
        }
    }
}
