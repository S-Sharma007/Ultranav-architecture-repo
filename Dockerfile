FROM openjdk:17-jdk-slim

# Create a non-root user
RUN useradd -ms /bin/bash jenkins

# Set up the application directory
RUN mkdir -p /usr/src/app && chown jenkins:jenkins /usr/src/app
WORKDIR /usr/src/app

# Switch to the non-root user
USER jenkins

# Copy the application JAR file
COPY target/spring-petclinic-3.1.0.jar /usr/src/app/petclinic.jar

# Expose the application port
EXPOSE 8081

# Add a health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD curl -f http://localhost:8081/actuator/health || exit 1

# Set the entry point
ENTRYPOINT ["java", "-jar", "petclinic.jar"]
