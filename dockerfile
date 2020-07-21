# run the static code analyzer


FROM maven:3.5-jdk-8 as build
WORKDIR /code
ADD pom.xml /code/pom.xml
ADD src /code/src
RUN ["mvn", "package" , "-Dmaven.test.skip=true"  ]


FROM newtmitch/sonar-scanner as sonarqube
WORKDIR /usr/src
COPY --from=build /code/target/*.jar /usr/src 
RUN sonar-scanner  -Dsonar.projectBaseDir=/usr/src -Dsonar.java.source=1.8

FROM openjdk:8-jre-alpine
WORKDIR /code
COPY --from=build /code/target/*.jar /code
CMD ["java -jar code/*.jar"]

#docker build  -t gansky/spring-petclinic:$(docker images --format='{{.ID}}' | head -1) -t gansky/spring-petclinic --network=spring-petclinic_sonarnet   .

#docker build  -t gansky/spring-petclinic:B$(BUILD_NUMBER) -t gansky/spring-petclinic --network=spring-petclinic_sonarnet   .