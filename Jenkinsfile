pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-token')  // Use Jenkins secret
        REPO_OWNER = "Rahman3030"
        REPO_NAME = "timeoff-management-application"
        WORKFLOW_FILE = "docker.yml" // GitHub Actions workflow filename
    }

    stages {
        stage('Trigger GitHub Actions') {
            steps {
                script {
                    sh """
                    curl -X POST -H "Accept: application/vnd.github+json" \
                    -H "Authorization: token $GITHUB_TOKEN" \
                    https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/workflows/$WORKFLOW_FILE/dispatches \
                    -d '{"ref":"master"}'
                    """
                }
            }
        }
    }
}

