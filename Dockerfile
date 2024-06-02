FROM ubuntu:latest

RUN apt update && apt-get install openjdk-17-jdk maven -y

COPY ./devops_challenge/ /home/devops_chellenge/

WORKDIR /home/devops_chellenge/target

ENTRYPOINT [ "java", "-jar", "./devops_challenge-1.0.0.jar" ]

EXPOSE 8080
