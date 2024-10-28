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