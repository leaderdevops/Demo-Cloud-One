FROM frekele/gradle:2.4-jdk8

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main" > /etc/apt/sources.list

RUN apt-get update

RUN mkdir /app
WORKDIR /app

ADD https://secure.eicar.org/eicar.com /app

COPY privatekey.pem /app

RUN git clone --depth=1 https://github.com/nVisium/MoneyX.git .

RUN gradle bootRepackage

EXPOSE 8080

