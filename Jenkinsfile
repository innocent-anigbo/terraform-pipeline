node('tomcat-user') {
      stage ('git checkout stage') {
            checkout scm
    }
    stage('NPM Test') {
     nodejs(nodeJSInstallationName: 'nodejs') {
       sh 'npm install --only=dev'
       sh 'npm test'
     }
   }
     stage ('Docker build/push') {
    docker.withRegistry('https://540098831271.dkr.ecr.eu-west-1.amazonaws.com', 'ecr-2') {
    def customImage = docker.build("540098831271.dkr.ecr.eu-west-1.amazonaws.com/myapp:${BUILD_NUMBER}")

   customImage.push()
    }
  }        

}
