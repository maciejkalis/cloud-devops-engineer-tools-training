pipeline {
    agent any
    options {
        copyArtifactPermission 'read-artifact'
    }
    stages {
        stage('Create-Artifact') {
            steps {
                // the `set` command is a built-in shell command that
                // prints the name and values of all variables visible
                // to the shell's environment.
                // https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
                //
                // The following uses the `sh` build step to run the
                // `set` command on the local system.  Note that if this
                // pipeline is run on a system that does not have a
                // built-in `set` command, any builds of the pipeline
                // will fail.  This may be the case on systems running
                // Windows OS with Powershell.
                sh "set > report.txt"
            }
        }
    }
    post {
        always {
            archiveArtifacts allowEmptyArchive: true,
                artifacts: 'report.txt',
                fingerprint: true,
                followSymlinks: false,
                onlyIfSuccessful: true
        }
    }
}