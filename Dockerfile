# Use the official OpenJDK 17 runtime as the base image
FROM eclipse-temurin:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build output to the container
COPY target/*.jar app.jar

# Expose the application port (adjust if your app runs on a different port)
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

