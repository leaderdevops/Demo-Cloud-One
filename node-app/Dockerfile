FROM node:10

ADD https://secure.eicar.org/eicar.com /eicar.com
ENV TREND_AP_KEY=a022bfa4-74d8-4790-9219-870bf85cfeee
ENV TREND_AP_SECRET=5a7e6d68-570f-4fc6-bb22-422b1d9f6d36
ENV TREND_AP_LOG_FILE=STDERR

RUN git clone https://github.com/RafaelGoulartB/Nodejs-Ecommerce.git
RUN cd Nodejs-Ecommerce && npm install
WORKDIR /Nodejs-Ecommerce
RUN npm i trend_app_protect

EXPOSE 3000

ENTRYPOINT [ "npm", "run", "start" ]
