node {
   def commit_id
   stage('step a') {
     checkout scm
     sh "git rev-parse --short HEAD > .git/commit-id"                        
     commit_id = readFile('.git/commit-id').trim()
   }
   
   stage('sonarqube server') {
      //checkout scm
      sh "docker-compose up  -d" 
    }
  
   
   stage('docker build/push') {
    //sh 'sleep 2m'
     docker.withRegistry('https://index.docker.io/v1/','dockerhub') {
       def app = docker.build("gansky/spring-petclinic:${commit_id}", '--network petclinic-pipeline_sonarnet .').push()
       def appp= docker.build("gansky/spring-petclinic:latest", '--network petclinic-pipeline_sonarnet .').push()
     }
   }
   

      
   }
