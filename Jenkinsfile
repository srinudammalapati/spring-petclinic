pipeline {
    agent any
     parameters {
         string (name: 'MAVEN_GOAL', defaultValue: 'CLEAN INSTALL', description: 'GOALS TO MAVEN')
          }

     triggers {
         pollSCM('* * * * *')
          }

    stages {
        stage ('Clone') {
            steps {
                git url: "https://github.com/srinudammalapati/spring-petclinic.git",
                branch: 'main'
            }
        }
         stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "JFROGID",
                    url: "https://rameshd.jfrog.io/",
                    credentialsId: "JFROG_ADMIN_IDS"
                )

                rtMavenDeployer (
                    id: "srinuid",
                    serverId: "JFROGID",
                    releaseRepo: "gopi-libs-release-local",
                    snapshotRepo: "gopi-libs-snapshot-local"
                )
            }
        }

        stage ('Exec Maven') {
            steps {
                rtMavenRun (
                    tool: MAVEN,
                    pom: 'pom.xml',
                    goals: "${params.MAVEN_GOAL}",
                    deployerId: "srinuid",
                )
            }
        }

        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "JFROGID"
                )
            }
        }
    }
}