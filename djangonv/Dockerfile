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
COPY private.key /private.key

# This will trigger a malware finding
ADD https://secure.eicar.org/eicar.com /eicar.com

# Initialize app database
RUN ["/reset_db.sh"]

# Add Cloud One Application Security
RUN pip install trend_app_protect
ENV TREND_AP_LOG_FILE=STDERR
ENV TREND_AP_KEY=2418e308-48e6-425a-8be3-ed6d20eb1367
ENV TREND_AP_SECRET=07562a0a-d623-4791-883f-b81b14056650

EXPOSE 8000

CMD ["/runapp.sh"]