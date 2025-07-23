# Compile Jar
FROM gradle:8.10.2-jdk21 AS build

WORKDIR /app

# Copy all project files
COPY . .

RUN gradle bootJar -x test --no-daemon

# Create a fastest execution image
FROM openjdk:21-jdk-slim

WORKDIR /app

# Copy jar generated before
COPY --from=build /app/fineract-provider/build/libs/*.jar fineract.jar

# Expose Fineract's default port
EXPOSE 8443

ENTRYPOINT ["java", "-jar", "fineract.jar"]