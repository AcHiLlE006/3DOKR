# 3DOKR - Déploiement Docker

Ce projet utilise Docker pour exécuter une stack composée de plusieurs services : `vote` (Python), `worker` (.NET), `result` (Node.js), `Redis` et `Postgres`.

---

## 🚀 Utilisation locale avec Docker Compose

Cette méthode est idéale pour le développement ou les tests en local.

### 🔧 Étapes :

1. Construire et lancer les services :
   ```bash
   docker-compose up --build
   ```

2. Accéder aux applications :
   - Vote App : http://localhost:5000
   - Result App : http://localhost:5001

---

## 🐝 Déploiement avec Docker Swarm

Cette méthode est utilisée pour un déploiement en production ou en cluster.

### 📦 Étapes :

1. **Construire les images localement** :
   ```bash
   docker build -t youruser/vote ./vote
   docker build -t youruser/worker ./worker
   docker build -t youruser/result ./result
   ```

2. **Pousser les images vers Docker Hub** :
   ```bash
   docker push youruser/vote
   docker push youruser/worker
   docker push youruser/result
   ```

3. **Initialiser le mode Swarm** :
   ```bash
   docker swarm init
   ```

4. **Déployer la stack** :
   ```bash
   docker stack deploy -c docker-stack.yml 3dokr
   ```

---

## 📝 Notes

- Remplace `youruser` par ton nom d'utilisateur Docker Hub.
- Le volume `db-data` est utilisé pour persister les données de Postgres.
- Le réseau `app-network` est utilisé pour permettre la communication entre services.

---

## 📂 Fichiers importants

- `docker-compose.yml` : pour le mode local
- `docker-stack.yml` : pour le déploiement Swarm avec `docker stack deploy`
