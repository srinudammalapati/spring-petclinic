pipeline {
    agent {label 'SPRING'}
    triggers {
      cron('* * * * *')
    }
    stages {
       stage('vcs') {
        steps {
            git url: 'https://github.com/srinudammalapati/spring-petclinic.git',
                branch: 'qa'    
        }
       }
        stage("build & SonarQube analysis") {
            steps {
              withSonarQubeEnv('dev_self_token') {
                sh "mvn package sonar:sonar"
              }
            }
          }
          stage("Quality Gate") {
            steps {
              timeout(time: 30, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true
              }
            }
          }       
       stage ('Artifactory configuration') {
            steps {
                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "supermahesh",
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
                    goals: 'install',
                    deployerId: "MAVEN_DEPLOYER"
                )
            }
        }
        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "supermahesh"
                )
            }
        }
        stage ('docker build and push') {
          agent {label 'DOCKER'}
          environment {
              AN_ACCESS_KEY = credentials('jfrog_id')
          }
          steps {
            sh 'docker image build -t spcdev:1.0 .'
            sh 'docker image tag spcdev:1.0 supermahesh.jfrog.io/test-docker-local/spcdev:1.0'
            sh 'docker image push supermahesh.jfrog.io/test-docker-local/spcdev:1.0'
          }
        }
    }  
}          