FROM mcr.microsoft.com/openjdk/jdk:21-ubuntu
ARG PORT=8080
COPY ./target/spring_boot_postgresql_crud-0.0.1.jar spring_boot_postgresql_crud.jar
ENTRYPOINT ["java","-Dserver.port=$PORT","-jar","/spring_boot_postgresql_crud.jar"]