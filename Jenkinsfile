pipeline {
    agent any
    stages {
       stage('vcs') {
        steps {
            git url: 'https://github.com/srinudammalapati/spring-petclinic.git',
                branch: 'main'    
        }
       }
       stage ('Artifactory configuration') {
            steps {
                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "QTSUPERUSER",
                    releaseRepo: 'qtdev-libs-release-local',
                    snapshotRepo: 'qtdev-libs-snapshot-local'
                )
           }
        }
        stage ('Exec Maven') {
            steps {
                rtMavenRun (
                    tool: 'MAVEN-3.6.3', // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'install',
                    deployerId: "MAVEN_DEPLOYER"
                )
            }
        }
        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "QTSUPERUSER"
                )
            }
        }
    }  
}          