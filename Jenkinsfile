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
    sh "mvn sonar:sonar -Dsonar.projectKey=devsecops-demo -Dsonar.host.url=http://etechdemo.eastus.cloudapp.azure.com:9000 -Dsonar.login=14ae25c1a64dd25d26979c1d43a926360571dda6"  
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
    stage('tf provision'){
      steps{
       sh "terraform init"
        sh "terraform plan"
        sh "terraform apply --auto-approve"
      }
    }
}
}
