pipeline {
    agent { label 'jenkins-agent' }

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

        stage('Run Ansible Playbook') {
            steps {
                sh '''
                ansible-playbook \
                  -i ansible/inventory/hosts.ini \
                  ansible/playbook.yml
                '''
            }
        }
    }
}
