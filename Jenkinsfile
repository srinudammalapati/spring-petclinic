pipeline {
    agent {label 'SPRING'}
    triggers {pollSCM '* * * * *'}
    stages {
       stage('vcs') {
        steps {
            git url: 'https://github.com/srinudammalapati/spring-petclinic.git',
                branch: 'qa'    
        }
       }
        stage("build & SonarQube analysis") {
            steps {
              withSonarQubeEnv('sonar') {
                sh "mvn package sonar:sonar"
              }
            }
          }    
       stage ('Artifactory configuration') {
            steps {
                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "jfrog",
                    releaseRepo: 'dev-libs-release-local',
                    snapshotRepo: 'dev-libs-snapshot-local'
                )
           }
        }
        stage ('Exec Maven') {
            steps {
                rtMavenRun (
                    tool: 'MAVEN_DEFAULT', // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'package',
                    deployerId: "MAVEN_DEPLOYER"
                )
            }
        }
        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "jfrog"
                )
            }
        }
        stage ('docker build and push') {
          agent {label 'DOCKER'}
          environment {
              AN_ACCESS_KEY = credentials('jdocker_ids')
          }
          steps {
            sh 'docker image build -t spcdev:1.0 .'
            sh 'docker image tag spcdev:1.0 supermahesh.jfrog.io/test-docker-local/spcdev:1.0'
            sh 'docker image push supermahesh.jfrog.io/test-docker-local/spcdev:1.0'
          }
        }
        stage('docker image pull'){
            agent {label 'DOCKER'}
            environment {
                AN_ACCESS_KEY = credentials('jdocker_ids')
            }
            steps{
                sh 'docker image pull supermahesh.jfrog.io/test-docker-local/spcdev:1.0'
                sh 'docker container run -d --name springpet -P spcdev:1.0'
                sh 'docker container ls -a'
            }
        }
    }  
}          