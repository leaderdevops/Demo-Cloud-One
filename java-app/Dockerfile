#FROM maven:3-alpine

FROM maven:3-jdk-8-alpine

COPY fake-rhel.tgz /

RUN tar -zxvf fake-rhel.tgz

# This will trigger at least 3 medium vulnerabilities in apache2
COPY lib-apk-db-installed /lib/apk/db/installed

# This will trigger the checklist scanner
# COPY /fake-rhel / 

# This will trigger an oscap finding for wordpress
COPY wpversion /fake/wp-includes/version.php

# This will trigger a malware finding
ADD https://secure.eicar.org/eicar.com /eicar.com

# This will trigger a content finding for a private key in PEM format
COPY cert.pem /cert.pem

RUN mkdir /tmp/extracted_files

COPY . /usr/src/goof
WORKDIR /usr/src/goof

ENV JAVA_TOOL_OPTIONS=-javaagent:/usr/src/goof/trend_app_protect-4.2.0.jar
ENV TREND_AP_KEY=dc6973c3-bb98-4905-909d-df915c865a05
ENV TREND_AP_SECRET=662b3285-828e-4dd6-8dbe-993f240a59d1
ENV TREND_AP_LOG_FILE=STDERR

RUN mvn install

EXPOSE 8080

ENTRYPOINT ["mvn", "tomcat7:run"]