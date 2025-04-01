FROM openjdk:17-jdk-slim
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -ms /bin/bash jenkins

# Set up the application directory
RUN mkdir -p /usr/src/app && chown jenkins:jenkins /usr/src/app
WORKDIR /usr/src/app

# Switch to the non-root user
USER jenkins

# Use pre-built JAR from Artifactory
ARG ARTIFACTORY_URL="https://trisha.jfrog.io/artifactory/petclinicbuild/spring-petclinic/spring-petclinic-3.1.0-SNAPSHOT.jar"
ARG ARTIFACTORY_PATH="petclinicbuild/spring-petclinic/spring-petclinic-3.1.0-SNAPSHOT.jar"

# Download JAR directly from Artifactory
RUN curl -o spring-petclinic-3.1.0-SNAPSHOT.jar ${ARTIFACTORY_URL}/${ARTIFACTORY_PATH} && chown jenkins:jenkins spring-petclinic-3.1.0-SNAPSHOT.jar

# Expose the application port
EXPOSE 8081

# Add a health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD curl -f http://localhost:8081/actuator/health || exit 1

# Set the entry point
ENTRYPOINT ["java", "-jar", "spring-petclinic-3.1.0-SNAPSHOT.jar"]
