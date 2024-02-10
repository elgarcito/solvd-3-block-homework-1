#In this Dockerfile, I use maven:3.8.4-openjdk-17-slim as the base image for the build stage.
#This image includes both Maven and OpenJDK, so you can use the mvn command

FROM maven:3.8.4-openjdk-17-slim as build
LABEL authors="edgar"

WORKDIR /app

# Copy pom.xml separately to avoid unnecessary rebuilds when source code changes
COPY pom.xml ./

# Download dependencies
RUN mvn dependency:go-offline -B

#Copy the working directory
COPY src ./src

# Build the application
RUN mvn package

# Start a new stage for running the application
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/solvd-block-3-homework-1-1.0-SNAPSHOT.jar ./

# Run the com.solvd.homework_1.Main Class
CMD ["java", "-jar", "solvd-block-3-homework-1-1.0-SNAPSHOT.jar"]


