FROM ubuntu

RUN apt-get install git curl

RUN apt-get update

RUN mkdir /app
WORKDIR /app

ADD https://secure.eicar.org/eicar.com /app

COPY privatekey.pem /app

EXPOSE 8080

