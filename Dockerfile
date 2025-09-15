# Stage 1: Build the Spring Boot app
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

# Download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source and build
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime image
FROM eclipse-temurin:21-jdk-jammy

# Optional: non-root user
RUN useradd --create-home appuser
USER appuser
WORKDIR /home/appuser

# Copy built JAR
COPY --from=build /app/target/*.jar app.jar

# Expose default port
EXPOSE 8080

# Use entrypoint that expands $PORT correctly
ENTRYPOINT ["java","-Dserver.port=${PORT:-8080}","-jar","app.jar"]

# Healthcheck so Dokku knows when app is ready
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s \
  CMD curl -f http://localhost:${PORT:-8080}/actuator/health || exit 1