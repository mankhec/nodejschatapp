node('ubuntu-Appserver')
{
    def index
    stage('Cloning Git')
    {
        checkout scm
    }

    stage('SCA-SAST-SNYK-TEST')
    {
        agent
        {
            label 'ubuntu-Appserver'
        }

        snykSecurity(
            snykInstallation: 'Snyk',
            snykTokenId: 'Snykid',
            severity: 'critical'
        )
    }

    stage('SonarQube Analysis')
    {
        agent
        {
            label 'ubuntu-Appserver'
        }
        script{
        def scannerHome = tool 'SonarQubeScanner'
        withSonarQubeEnv('sonarqube') {
            sh "${scannerHome}/bin/sonar-scanner \
                -Dsonar.projectKey=gameapp \
                -Dsonar.sources=."
        }
    }
    }

    stage('Build-and-Tag')
    {
        app = docker.build('kevenmang/index')
    }

    stage('Post-to-Dockerhub')
    {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials')
        {
            app.push('latest')
        }
    }

    stage('Deploy')
    {
        sh 'docker-compose down'
        sh 'docker-compose up -d'
    }
}