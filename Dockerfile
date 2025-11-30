# Etapa de build: compila el jar con Maven usando Java 21
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app

# Copiamos archivos de Maven wrapper y POM primero para aprovechar cache
COPY pom.xml ./
COPY .mvn .mvn
COPY mvnw mvnw

RUN chmod +x mvnw

# Descarga dependencias en cache
RUN ./mvnw -q -B dependency:go-offline

# Copiamos el código fuente
COPY src src

# Build del jar (sin tests para agilizar)
RUN ./mvnw -q -B clean package -DskipTests

# Etapa de runtime: JRE minimal con Java 21
FROM eclipse-temurin:21-jre
WORKDIR /app

# Nombre del jar según  pom.xml (artifactId=testeo, version=0.0.1-SNAPSHOT)
COPY --from=build /app/target/testeo-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app/app.jar"]
