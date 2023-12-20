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
          stage('Checkout Code') {
            steps {
                   checkout([$class: 'GitSCM', branches: [[name: 'feature']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'Or_Github', url: "${GITHUB_REPO_URL}"]]])
            }
          }
        stage('Build Docker Image') {
            steps {
                  container('dind') {
                                  script {
                                          echo "started building image...."
                                          sh 'dockerd &'
                                          sh 'sleep 8'
                                          sh "docker build -t ${IMAGE_NAME} ."
                                        echo "finished"
                                  }
                        }
                    }
                }
          stage('Push Docker Image') {
            steps {
                container('dind') {
                        withCredentials([usernamePassword(credentialsId: 'Or_Dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                        sh "docker push ${IMAGE_NAME}"
                                          }
            }
        }
      }
    }

        // Additional stages or steps can be added as needed
    }
