FROM node:carbon AS base
MAINTAINER Shudarshon Chaki, sdrsn.chaki@gmail.com

WORKDIR /app

COPY package.json ./
RUN npm set progress=false && \
    npm install -s --no-progress && \
    npm cache clean --force && \
    rm -rf /tmp/*

FROM node:8.9-alpine AS release

WORKDIR /app

COPY --from=base /app/node_modules /app/node_modules
COPY . /app

USER node
EXPOSE 3000
CMD ["npm", "run", "start:dev"]
