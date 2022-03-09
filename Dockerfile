# syntax=docker/dockerfile:1
FROM node:16-alpine AS development
WORKDIR /usr/src/app
ENV NODE_ENV=development
COPY ["./package.json", "./package-lock.json", "./"]
RUN npm install
RUN apk add --no-cache bash

FROM node:16-alpine AS build
USER node
WORKDIR /usr/src/app
ENV NODE_ENV=production
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
COPY ["./package.json", "./package-lock.json", "./"]
RUN npm ci --only=production && npm cache clean --force
COPY . .
RUN npm run build
RUN deluser --remove-home node

FROM nginx:1.21.6-alpine AS production
WORKDIR /usr/share/nginx/html
COPY --from=build /usr/src/app/build/ ./
COPY --from=build /usr/src/app/nginx.conf /etc/nginx/conf.d/default.conf
