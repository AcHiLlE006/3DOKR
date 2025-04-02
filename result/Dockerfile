FROM node:18
WORKDIR /app
COPY result/package.json result/package-lock.json ./
RUN npm install
COPY result/ .
CMD ["node", "server.js"]