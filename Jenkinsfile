pipeline {
    agent {
            label "docker && linux"
    } 

    environment {
        VERSION = vault path: "DevOps/RELEASE_VERSIONS", key: 'OSCRIPT'
    }

    stages {
        stage('Build image') {
            steps {
                echo 'Starting to build docker image'             
                script{
                    def secrets = [
                    [path: "infastructure/gitlab", engineVersion: 2, secretValues: [
                        [envVar: 'CI_BOT_TOKEN', vaultKey: 'ci-bot']
                    ]]
                ]           
                    withVault([configuration: [timeout: 60], vaultSecrets: secrets ]){ 
                        sh "docker login -u ci-bot -p ${CI_BOT_TOKEN} registry.oskk.1solution.ru"
                        sh "docker build -t registry.oskk.1solution.ru/docker-images/oscript:${VERSION} --build-arg BUILD=latest --build-arg VERSION=${VERSION} ."
                        sh "docker push registry.oskk.1solution.ru/docker-images/oscript:${VERSION}"
                    }
                }            
            }
        }
    }
}
