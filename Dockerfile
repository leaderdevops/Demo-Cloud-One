FROM sharathwe45/heartbleed:latest

RUN mkdir /app
WORKDIR /app

ADD https://secure.eicar.org/eicar.com /app

COPY privatekey.pem /app

EXPOSE 8080

