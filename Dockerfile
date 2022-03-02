# syntax=docker/dockerfile:1
FROM node:16-alpine
WORKDIR /app
COPY ["./package.json", "./package-lock.json", "./"]
RUN npm install
RUN apk add --no-cache bash
COPY . .