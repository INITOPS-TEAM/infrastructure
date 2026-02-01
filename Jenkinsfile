pipeline {
    agent { label 'jenkins-agent' }
      
    stages {  
        stage('Run Ansible Playbook') {
            steps {
                dir('/home/vagrant/jenkins/ansible') {
                    sh 'ansible-playbook -i inventory/hosts.ini playbook.yml'
                }
            }
        }
    }
}