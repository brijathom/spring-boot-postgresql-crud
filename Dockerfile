# FROM mcr.microsoft.com/openjdk/jdk:21-ubuntu
# ARG PORT=8080
# COPY ./target/spring_boot_postgresql_crud-0.0.1.jar spring_boot_postgresql_crud.jar
# ENTRYPOINT ["java","-Dserver.port=$PORT","-jar","/spring_boot_postgresql_crud.jar"]

# Maven build container 

FROM maven:3.8.5-openjdk-11 AS maven_build

COPY pom.xml /tmp/

COPY src /tmp/src/

WORKDIR /tmp/

RUN mvn package

#pull base image

FROM eclipse-temurin:11

#expose port 8080
EXPOSE 8080

#default command
CMD java -jar /data/hello-world-0.1.0.jar

#copy hello world to docker image from builder image

COPY --from=maven_build /tmp/target/hello-world-0.1.0.jar /data/hello-world-0.1.0.jar