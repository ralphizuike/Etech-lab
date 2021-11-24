pipeline {
  agent any

  stages {
      stage('Build Artifact') {
            steps {
              sh "mvn clean package -DskipTests=true"
              archive 'target/*.jar' //so that they can be downloaded later
            }
        }
    stage('unit test'){
      steps{
      sh 'mvn test'
      }
      post {
        always {
          junit 'target/surefire-reports/*.xml'
          jacoco execPattern: 'target/jacoco.exec'
        }
      }
    }
        stage('Mutation Tests - PIT') {
            steps {
        sh "mvn org.pitest:pitest-maven:mutationCoverage"
      }
      post {
        always {
          pitmutation mutationStatsFile: '**/target/pit-reports/**/mutations.xml'
        }
      }
        }
    stage('Sonarqube-SAST'){
      steps{
    sh "mvn sonar:sonar -Dsonar.projectKey=devsecops-demo -Dsonar.host.url=http://etechdemo.eastus.cloudapp.azure.com:9000 -Dsonar.login= 27bbb5c1909c29083c484fd6e59ee4e69a6d78d1"  
      }
    }
    stage('Docker Build and Push') {
      steps {
        withDockerRegistry([credentialsId: "docker-hub", url: ""]) {
          sh 'printenv'
          sh 'docker build -t enkengaf32/uber-app:17""$GIT_COMMIT"" .'
          sh 'docker push enkengaf32/uber-app:17""$GIT_COMMIT""'
        }
      }
    }
      stage('Kubernetes Deployment - DEV') {
      steps {
        withKubeConfig([credentialsId: 'kubeconfig']) {
          sh "kubectl apply -f k8s_deployment_service.yaml"
        }
      }
    }
}
}
