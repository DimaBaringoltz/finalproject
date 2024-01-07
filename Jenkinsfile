def dockerImage;
pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {
        stage('checkout') {
            steps {
                script {
                    def branchName = env.BRANCH_NAME
                    git branch: branchName, credentialsId: 'github', url: 'https://github.com/DimaBaringoltz/finalproject.git'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build('tzvitsuryev/employees-app:edge')
                }
            }

        }

        stage('Run unittest') {
            steps {
                script {
                    dockerImage.inside {
                        sh 'python -m unittest discover -s tests'
                    }
                }
            }
        }
        
        
        stage('Run Api Tests') {
             when {
                expression {
                    return env.BRANCH_NAME != 'develop'
                }
            }
            steps {
                script {
                    def dockerContainer;
                    try {
                        dockerContainer = dockerImage.run()
                        sh "docker exec ${dockerContainer.id} python3 -m pytest /app/tests/api_tests.py"
                    } finally  {
                        dockerContainer.stop()
                    }
                }
            }
        }
        
        stage('Push Image to Docker Hub') {
             when {
                expression {
                    return env.BRANCH_NAME == 'master'
                }
            }
            steps {
                script {
                    // Login to Docker Hub (replace credentials with yours)
                    withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                        dockerImage.push()
                    }
                }
            }
        }

    }

}
