# run the static code analyzer


FROM maven:3.5-jdk-8 as build
WORKDIR /code
ADD pom.xml /code/pom.xml
ADD src /code/src
RUN ["mvn", "package" , "-Dmaven.test.skip=true"  ]


FROM newtmitch/sonar-scanner as sonarqube
WORKDIR /usr/src
COPY --from=build /code/target/*.jar /usr/src 
RUN sonar-scanner  -Dsonar.projectBaseDir=/usr/src  -Dsonar.exclusions=**.java


FROM openjdk:8-jre-alpine
WORKDIR /code
COPY --from=build /code/target/*.jar /code
CMD ["java","-jar","spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar"]

  

 ## must install docker-compose on jenkins cont
#     curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
