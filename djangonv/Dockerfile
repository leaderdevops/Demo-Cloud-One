# Dockerfile

# Start with the latest python 2.x version
FROM python:2.7.13

# Build App
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY appcode/requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt
COPY appcode/ /usr/src/app
COPY appcode/reset_db.sh /reset_db.sh
# Get the "built" version of runapp.sh
COPY appcode/runapp.sh /runapp.sh
COPY cert.pem /cert.pem

# This will trigger a malware finding
ADD https://secure.eicar.org/eicar.com /eicar.com

# Initialize app database
RUN ["/reset_db.sh"]

# Add Cloud One Application Security
RUN pip install trend_app_protect
ENV TREND_AP_LOG_FILE=STDERR
ENV TREND_AP_KEY=$TREND_AP_KEY
ENV TREND_AP_SECRET=$TREND_AP_SECRET

# Expose ports to internet
EXPOSE 8000

# Run the app
CMD ["/runapp.sh"]