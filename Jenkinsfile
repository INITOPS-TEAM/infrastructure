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
                    sshagent(['pictapp-dev-ssh']) {    
                        withCredentials([[ $class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-access-key-veronika',secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
                            sh 'ansible-playbook -i inventory/dynamic_aws_ec2.yml playbook.yml -vv'
                        }
                    }    
                }
            }
        }
    }
}
