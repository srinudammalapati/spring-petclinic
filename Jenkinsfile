pipeline {
    agent { label 'sonar'}
    stages {
        stage (clone) {
            steps {
                git url: 'https://github.com/srinudammalapati/spring-petclinic.git',
                branch: 'main'
            }
        }
        stage("build & SonarQube analysis") {
            steps {
                 withSonarQubeEnv('srinu') {
                
                    sh 'mvn clean package sonar:sonar'
           }
              
            }
        }
    }
}