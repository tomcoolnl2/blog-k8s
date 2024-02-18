FROM node:18.17.0 as base

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

EXPOSE 4003

FROM base AS start
CMD ["npm", "run", "start:docker"]