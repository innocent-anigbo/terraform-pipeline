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
       def ecr = "`aws ecr get-login --region eu-west-1`"
       ecr
       docker.withRegistry('https://540098831271.dkr.ecr.eu-west-1.amazonaws.com') {
       def customImage = docker.build("540098831271.dkr.ecr.eu-west-1.amazonaws.com/myapp:${BUILD_NUMBER}")

   customImage.push()
    }
  }        
    stage ('Terraform Plan') {
       sh 'pwd'
       sh 'cd terraform-code && terraform init -backend-config="bucket=terraform-state-file-inno" -backend-config="key=terraform" -backend-config="region=eu-west-1" && terraform plan -var MYAPP_VERSION=${BUILD_NUMBER}'
     
   }
   stage ('Terraform Apply') {
        timeout(time:5, unit:'DAYS'){
            input message:'Approve Infrastructure setup and Deployment?', submitter: 'innocent.anigbo@mykezy.com'
                }
       sh 'cd terraform-code && terraform apply -var MYAPP_VERSION=${BUILD_NUMBER}'

   }

}
