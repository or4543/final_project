pipeline {
      agent {
            kubernetes {
                label 'dind-agent'
                yamlFile 'agent.yaml'
            }
        }
            environment {
                GITHUB_REPO_URL = 'https://github.com/or4543/final_project.git'  // Replace with your GitHub repository URL
                IMAGE_NAME = 'or3534/demo_app:latest'  // Specify your Docker Hub image name and tag
            }
 
    stages {
        stage('Build Docker Image') {
            steps {
                  container('dind') {
                                  script {
                                      checkout([$class: 'GitSCM', branches: [[name: 'feature']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'Or_Github', url: "${GITHUB_REPO_URL}"]]])
                                          sh "docker build -t ${IMAGE_NAME} ."
                                          withCredentials([usernamePassword(credentialsId: 'Or_Dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                                          sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                                              // Push the Docker image to Docker Hub
                                          sh "docker push ${IMAGE_NAME}"
                                          }
                                  }
                    }
                }
            }
        }

        // Additional stages or steps can be added as needed
    }

