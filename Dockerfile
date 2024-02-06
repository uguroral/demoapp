FROM maven:3.9.0-eclipse-temurin-17 as build
WORKDIR /app
COPY . .

FROM eclipse-temurin:17.0.6_10-jdk
WORKDIR /app
COPY --from=build /app/target/demoapp.jar /app/
EXPOSE 8080
RUN apt update && apt install -y openssh-server
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
ENTRYPOINT service ssh start && bash
CMD ["java", "-jar","demoapp.jar"]