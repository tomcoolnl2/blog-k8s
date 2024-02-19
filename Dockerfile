FROM node:18.17.0 as base

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

FROM base AS start
CMD ["npm", "start"]