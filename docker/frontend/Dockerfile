FROM node:23.11.0-slim

WORKDIR /app

COPY src/frontend/package*.json ./
RUN npm install

COPY src/frontend ./

RUN npm run build

CMD ["npm", "run", "start"]