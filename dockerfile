# run the static code analyzer
FROM newtmitch/sonar-scanner as sonarqube
WORKDIR /usr/src
COPY  ./src/* ./
RUN sonar-scanner -Dsonar.projectBaseDir=/usr/sr

FROM maven:3.5-jdk-8-alpine as build 
WORKDIR /app
COPY ./* /app 
RUN mvnw package

FROM openjdk:8-jre-alpine
WORKDIR /code
COPY --from=build /app/target/*.jar /code
CMD ["java -jar code/*.jar"]
