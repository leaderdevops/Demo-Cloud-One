FROM httpd:2.4

COPY private_unencrypted.pem /private_unencrypted.pem

EXPOSE 8080