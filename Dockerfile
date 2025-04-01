FROM openjdk:17-jdk-slim

# Create a non-root user
RUN useradd -ms /bin/bash jenkins

# Set up the application directory
RUN mkdir -p /usr/src/app && chown jenkins:jenkins /usr/src/app
WORKDIR /usr/src/app

# Switch to the non-root user
USER jenkins

# Use pre-built JAR from Artifactory
ARG ARTIFACTORY_URL="https://trisha.jfrog.io/artifactory"
ARG ARTIFACTORY_PATH="petclinicbuild/org/springframework/samples/jenkins/3.1.0-SNAPSHOT/jenkins-3.1.0-SNAPSHOT.jar"

# Download JAR directly from Artifactory
RUN curl -o app.jar ${ARTIFACTORY_URL}/${ARTIFACTORY_PATH} && chown jenkins:jenkins app.jar
COPY --chown=jenkins:jenkins app.jar app.jar

# Expose the application port
EXPOSE 8081

# Add a health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD curl -f http://localhost:8081/actuator/health || exit 1

# Set the entry point
ENTRYPOINT ["java", "-jar", "petclinic.jar"]
