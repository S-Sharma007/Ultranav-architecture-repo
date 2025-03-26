# Use the official Maven image to build the application
FROM maven:3.8.6-openjdk-17-slim AS build
# Set the working directory in the container    
WORKDIR /app
# Copy the pom.xml and the source code to the container
COPY pom.xml .
COPY src ./src
# Build the application using Maven
RUN mvn clean package -DskipTests
# Use the official OpenJDK image to run the application
FROM openjdk:17-jdk-slim
# Set the working directory in the container
WORKDIR /app
# Copy the built JAR file from the build stage to the current working directory
COPY --from=build /app/target/*.jar app.jar
# Expose the application on port 8080
EXPOSE 8080
# Set the command to run the application
CMD ["java", "-jar", "app.jar"]
