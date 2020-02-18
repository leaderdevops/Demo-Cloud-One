FROM frekele/gradle:2.4-jdk8

RUN apt-get update

RUN mkdir /app
WORKDIR /app

ADD https://secure.eicar.org/eicar.com /app

COPY privatekey.pem /app

EXPOSE 8080

