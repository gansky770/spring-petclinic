node {
   def commit_id
   stage('step a') {
     checkout scm
     sh "git rev-parse --short HEAD > .git/commit-id"                        
     commit_id = readFile('.git/commit-id').trim()
   }
   //stage('docker compose up') {
     //sh "docker-composer build"
     //sh "docker-compose up -d"
   //  sh label: '', script: """
     // "docker-compose up --force-recreate --abort-on-container-exit -f docker-compose.yml"
    // """
     //}
   
   stage('docker build/push') {
     docker.withRegistry('https://index.docker.io/v1/','dockerhub') {
       def app = docker.build("gansky/spring-petclinic:${commit_id}", '/.').push()
       def appp= docker.build("gansky/spring-petclinic:latest", '/.').push()
     }
   }
   //stage('docker compose down') {
     //sh label: '', script: """
      //"docker-compose  down -v"
    // """
     //}

      
   }
