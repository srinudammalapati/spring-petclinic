pipeline{
    agent {label 'JDK11-MAVEN'}
    parameters{
        choice(name: 'BRANCH_TO_BUILD', choices: ['main', 'develop',], description: 'branch to build')
        string(name: 'MAVEN_GOAL', defaultValue: 'package', description: 'maven goal')
    }
    stages{
       stage('gitclone') {
        steps{
            git url: 'https://github.com/srinudammalapati/spring-petclinic.git',
            branch: "${params.BRANCH_TO_BUILD}"
        }
       }
       stage('build'){
        steps{
            sh "mvn ${params.MAVEN_GOAL}"
        }
       }
       stage('archive results'){
        steps{
           junit '**/surefire-reports/*.xml'
        }
       }
    }
}