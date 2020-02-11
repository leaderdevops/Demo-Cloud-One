FROM debian:wheezy

# Environment
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

# Get current
RUN apt-get update -y
RUN apt-get dist-upgrade -y
