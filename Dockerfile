# FROM mcr.microsoft.com/openjdk/jdk:21-ubuntu
# ARG PORT=8080
# COPY ./target/spring_boot_postgresql_crud-0.0.1.jar spring_boot_postgresql_crud.jar
# ENTRYPOINT ["java","-Dserver.port=$PORT","-jar","/spring_boot_postgresql_crud.jar"]

# Stage 1: build the app
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copy pom and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source and build
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: runtime image
FROM eclipse-temurin:21-jdk-jammy

# Optional: set a non-root user (for better security)
# RUN useradd --create-home appuser
# USER appuser

# WORKDIR /home/appuser

# Copy jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port (default Spring Boot port)
EXPOSE 8080

# Define entrypoint
ENTRYPOINT ["java","-jar","app.jar"]