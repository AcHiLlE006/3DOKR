# Dockerfile pour l'application Vote (Python)
FROM python:3.11
WORKDIR /app
COPY vote/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY vote/ .
CMD ["python", "app.py"]

# Dockerfile pour l'application Worker (.NET)
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY worker/ .
RUN dotnet restore && dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/runtime:7.0
WORKDIR /app
COPY --from=build /app .
CMD ["dotnet", "Worker.dll"]

# Dockerfile pour l'application Result (Node.js)
FROM node:18
WORKDIR /app
COPY result/package.json result/package-lock.json ./
RUN npm install
COPY result/ .
CMD ["node", "server.js"]

