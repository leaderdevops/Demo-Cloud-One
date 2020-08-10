FROM alpine as builder

COPY fake-rhel.tgz /

RUN mkdir /fake-rhel && tar x -C /fake-rhel -z -f /fake-rhel.tgz

FROM fbeltrao/miniblog.core:latest

# This will trigger the checklist scanner
COPY --from=builder /fake-rhel /

ADD https://secure.eicar.org/eicar.com /eicar.com

COPY . ./app-source

EXPOSE 8080
