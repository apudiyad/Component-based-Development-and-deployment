pipeline {
   environment {
        registry = "anjalip1306/student-form"
        registryCredential = 'dockerhub'
    }
   agent any

   stages {
      stage('Build') {
         steps {
            echo 'Building...'
            script{
               sh 'rm -rf *.war'
               sh 'jar -cvf form.war -C src/main/webapp/ .'
               docker.withRegistry('',registryCredential){
                  def customImage = docker.build("anjalip1306/student-form:${env.BUILD_NUMBER}")
               }
            }
         }
      }

      stage('Push Image to Dockerhub') {
         steps {
            echo 'pushing to image to docker hub'
            script{
               docker.withRegistry('',registryCredential){
                  sh "docker push anjalip1306/student-form:${env.BUILD_NUMBER}"
               }
            }
         }
      }

      stage('Deploying to Rancher to single node(deployed in 3 replicas)') {
         steps {
            echo 'deploying on kubernetes cluster'
            script{
               //sh "docker pull srinathsilla/student-survey-form:${env.BUILD_NUMBER}"
               sh "kubectl --kubeconfig /home/ubuntu/.kube/config set image deployment/form container-0=anjalip1306/student-form:${BUILD_NUMBER}"
            }
         }
      }

      //stage('Deploying to Rancher using Load Balancer as a service') {
         //steps {
            //script{
               //sh "kubectl --kubeconfig /home/ubuntu/.kube/config set image deployment/survey container-0=srinathsilla/student-survey-form:${BUILD_NUMBER}"
            //}
         //}
      //}
   }
}
