pipeline {
    agent any
    stages {
        stage('Read-Artifact') {
            steps {
                copyArtifacts projectName: 'create-artifact',
                    filter: 'report.txt',
                    fingerprintArtifacts: true,
                    selector: lastSuccessful()
            }
        }
    }
}