pipeline{
    agent {label 'JDK11-MAVEN'}
    stages{
       stage('gitclone') {
        steps{
            git url: 'https://github.com/srinudammalapati/spring-petclinic.git',
            branch: 'main'
        }
       }
       stage('build'){
        steps{
            sh 'mvn package'
        }
       }
       stage('archive results'){
        steps{
           junit '**/surefire-reports/*.xml'
        }
       }
    }
}