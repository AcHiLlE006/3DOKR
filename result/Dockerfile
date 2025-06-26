FROM node:18
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
EXPOSE 5001
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 CMD curl -f http://localhost:5001/ || exit 1
RUN adduser --disabled-password --gecos '' appuser && chown -R appuser /app
USER appuser
CMD ["npm", "start"]
