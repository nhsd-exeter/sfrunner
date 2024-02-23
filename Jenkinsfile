pipeline {

    agent any

    environment {
        // Define the Task version to install
        TASK_VERSION = '3.34.1'
        // Determine the architecture and set the download URL for Task
        TASK_DOWNLOAD_URL = ''
    }

    stages {

        stage('Prepare Environment') {
            steps {
                script {
                    // Detect architecture
                    if (isUnix()) {
                        def arch = sh(script: 'uname -m', returnStdout: true).trim()
                        echo "Detected architecture: ${arch}"

                        // Set the download URL based on architecture
                        if (arch == 'x86_64') {
                            env.TASK_DOWNLOAD_URL = "https://github.com/go-task/task/releases/download/v${env.TASK_VERSION}/task_linux_amd64.tar.gz"
                        } else if (arch.startsWith('arm') || arch.startsWith('aarch64')) {
                            env.TASK_DOWNLOAD_URL = "https://github.com/go-task/task/releases/download/v${env.TASK_VERSION}/task_linux_arm64.tar.gz"
                        } else {
                            error "Unsupported architecture: ${arch}"
                        }
                    } else {
                        error "Unsupported OS"
                    }
                }
            }
        }

        stage('Install Task') {
            steps {
                script {
                    // Download and install Task
                    sh """
                        curl -sL ${env.TASK_DOWNLOAD_URL} -o task.tar.gz
                        tar -xzf task.tar.gz
                        mv task /tmp/task
                        /tmp/task --version
                    """
                }
            }
        }

        stage('Run Task: infra:plan') {
            steps {
                sh "/tmp/task infra:init"
                sh "/tmp/task infra:plan"
                sh "/tmp/task infra:apply"
            }
        }
    }

    post {
        always {
            // Optional: Clean up by removing the Task binary
            sh "rm -f /tmp/task"
            sh "rm -f ${TASK_FILE}"
        }
    }
}