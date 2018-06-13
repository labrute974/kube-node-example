FROM node:10-alpine

RUN apk update
RUN apk upgrade
RUN npm i -g forever

ADD target/app.tgz /app

WORKDIR /app
ENTRYPOINT forever ./index.js
