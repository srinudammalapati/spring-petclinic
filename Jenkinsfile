pipeline {
    agent { label 'openjdk-11-maven'}
    stages {
        stage ('Clone') {
            steps {
                git branch: 'main', url: "https://github.com/srinudammalapati/spring-petclinic.git"
            }
        }

        stage ('build') {
            steps {
                sh 'mvn package'
            }
        }

        stage ('archive results') {
            steps {
              junit '**/surefire-reports/*.xml'
            }
        }
    }
}