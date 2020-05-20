FROM frekele/gradle:2.4-jdk8

# RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main" > /etc/apt/sources.list

# Install necessary packages and general cleanup
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends git
RUN rm -rf /var/lib/apt/lists/*

# Define app directory
RUN mkdir /app
WORKDIR /app

# This will trigger a malware finding
ADD https://secure.eicar.org/eicar.com /eicar.com

# This will trigger a content finding for a private key in PEM format
COPY cert.pem /cert.pem

# This will trigger Snyk rules
RUN git clone --depth=1 https://github.com/nVisium/MoneyX.git .

# Build App
RUN gradle bootRepackage

# Add Cloud One Application Security
ADD https://files.trendmicro.com/products/CloudOne/ApplicationSecurity/1.0/trend_app_protect-4.1.2.jar trend_app_protect-4.1.2.jar
CMD java -javaagent:trend_app_protect-4.1.2.jar -jar build/libs/moneyx.jar
ENV TREND_AP_LOG_FILE=STDERR
ENV TREND_AP_KEY=$TREND_AP_KEY
ENV TREND_AP_SECRET=$TREND_AP_SECRET

# Expose ports to internet
EXPOSE 8080