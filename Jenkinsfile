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
    stage ('Terraform Plan') {
       sh 'pwd'
       sh 'cd terraform-code && terraform plan -target aws_ecs_service.myapp-service -var MYAPP_SERVICE_ENABLE="1" -var MYAPP_VERSION=${BUILD_NUMBER}'
     
   }
   stage ('Terraform Apply') {
        timeout(time:5, unit:'DAYS'){
            input message:'Approve Infrastructure setup and Deployment?', submitter: 'innocent.anigbo@mykezy.com'
                }
       sh 'cd terraform-code && terraform plan -target aws_ecs_service.myapp-service -var MYAPP_SERVICE_ENABLE="1" -var MYAPP_VERSION=${BUILD_NUMBER}'

   }

}
