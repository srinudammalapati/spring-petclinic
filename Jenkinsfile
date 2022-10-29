pipeline {
    agent any
    stages {
        stage ('git clone') {
            steps {
                git url: "https://github.com/srinudammalapati/spring-petclinic.git",
                branch: 'main'
            }
        }
        stage ('build') {
            steps {
                sh 'mvn package'
            }
        }
    }
}