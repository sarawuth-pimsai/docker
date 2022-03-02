# syntax=docker/dockerfile:1
FROM node:16-alpine
RUN apk add --no-cache bash
ENV NODE_ENV=development
WORKDIR /app
COPY ["./package.json", "./package-lock.json", "./"]
RUN npm install
COPY . .