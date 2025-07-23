# Compile Jar
FROM gradle:8.5.0-jdk17 AS builder

WORKDIR /app
COPY --chown=gradle:gradle . /app

RUN gradle bootJar -x test --no-daemon

# create execution image
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy jar generated before
COPY --from=builder /app/fineract-provider/build/libs/*.jar fineract.jar

# Expose Fineract default port
EXPOSE 8443

ENTRYPOINT ["java", "-jar", "fineract.jar"]

