pipeline {
    environment {
        registry = "anjalip1306/survey"
        registryCredential = 'dockerhub'
    }
    agent any

    stages {
        stage('Setup Kubectl') {
            steps {
                script {
                    def kubectlPath = sh(script: 'which kubectl', returnStdout: true).trim()
                    env.PATH = "${env.PATH}:${kubectlPath}"
                }
            }
            post {
                always {
                    script {
                        sh "chown -R jenkins:jenkins /home/ubuntu/.kube"
                        sh "chmod 700 /home/ubuntu/.kube"
                        sh "chmod 600 /home/ubuntu/.kube/config"

                    }
                }
            }
        }

        stage('Build') {
            steps {
                echo 'Building...'
                script {
                    sh 'rm -rf *.war'
                    sh 'jar -cvf form.war -C src/main/webapp/ .'
                    docker.withRegistry('', registryCredential) {
                        def customImage = docker.build("anjalip1306/survey:${env.BUILD_NUMBER}")
                    }
                }
            }
        }

        stage('Push Image to Dockerhub') {
            steps {
                echo 'pushing to image to docker hub'
                script {
                    docker.withRegistry('', registryCredential) {
                        sh "docker push anjalip1306/survey:${env.BUILD_NUMBER}"
                    }
                }
            }
        }

        stage('Deploying to Rancher to single node (deployed in 3 replicas)') {
            steps {
                echo 'deploying on Kubernetes cluster'
                script {
                    sh "kubectl --kubeconfig /home/ubuntu/.kube/config set image deployment/survey container-0=anjalip1306/survey:${BUILD_NUMBER}"
                }
            }
        }

        //stage('Deploying to Rancher using Load Balancer as a service') {
          //  steps {
             //   script {
               //     sh "kubectl --kubeconfig /home/ubuntu/.kube/config set image deployment/hw2-cluster-lb container-0=anjalip1306/survey:${BUILD_NUMBER}"
                //}
            //}
       // }
    }
}
