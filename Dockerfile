# syntax=docker/dockerfile:1
FROM node:16-alpine
RUN apk add --no-cache bash
ENV NODE_ENV=develop
WORKDIR /app
COPY ["./package.json", "./package-lock.json", "./"]
# RUN npm install
COPY . .