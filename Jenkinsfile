pipeline {
    agent any
    stages {
        stage ('Clone') {
            steps {
                git branch: 'main', url: "https://github.com/srinudammalapati/spring-petclinic.git"
            }
        }

        stage ('jfrog') {
            steps {
                rtMavenDeployer (
                    id: "srinu_DEPLOYER",
                    serverId: "srinuserver id",
                    releaseRepo: default-libs-release-local,
                    snapshotRepo: default-libs-snapshot-local
                )
            }
        }

        stage ('Exec Maven') {
            steps {
                rtMavenRun (
                    tool:  MAVEN_PACKAGE, // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: "srinu_DEPLOYER",
                )
            }
        }

        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "srinuserver id"
                )
            }
        }
    }
}