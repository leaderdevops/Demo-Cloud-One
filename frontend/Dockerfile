FROM frekele/gradle:2.4-jdk8

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main" > /etc/apt/sources.list

RUN apt-get update && apt-get install --force-yes --no-install-recommends git && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

# This will trigger a malware finding
ADD https://secure.eicar.org/eicar.com /eicar.com

COPY private_unencrypted.pem /private_unencrypted.pem
COPY cert.key /cert.key

RUN git clone --depth=1 https://github.com/nVisium/MoneyX.git .

RUN gradle bootRepackage

ADD https://files.trendmicro.com/products/CloudOne/ApplicationSecurity/1.0/trend_app_protect-4.1.2.jar trend_app_protect-4.1.2.jar

EXPOSE 8080

CMD java -javaagent:trend_app_protect-4.1.2.jar -jar build/libs/moneyx.jar

ENV TREND_AP_LOG_FILE=STDERR
ENV TREND_AP_KEY=2418e308-48e6-425a-8be3-ed6d20eb1367
ENV TREND_AP_SECRET=07562a0a-d623-4791-883f-b81b14056650