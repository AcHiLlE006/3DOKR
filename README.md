# 🐳 Projet de Vote Distribué

Ce projet met en place une architecture distribuée avec Docker pour permettre de voter entre deux options.  
Il est basé sur 3 services applicatifs principaux :

- `vote` (Frontend Flask)
- `worker` (.NET, traite les votes)
- `result` (Node.js, visualise les résultats)

Ainsi que deux services techniques :

- `redis` (file d’attente des votes)
- `postgres` (stockage des votes)

---

Des modifications ont été effectués sur le code source afin notamment afin d'exposer sur l'application vote sur le port 5000.
La connectionString de result a également était modifiée afin de la connecter à la base de données postgres.
Les variables de connections de worker ont aussi étaient modifié afin d'être connecté au redis et au postgres.

## 🧪 Tester localement avec Docker Compose

### 1. Lancer tous les services
```bash
docker-compose up --build -d
```

### 2. Vérifier l’état des services
```bash
docker-compose ps
```

### 3. Accéder aux interfaces
- 🗳 Page de vote : http://localhost:5000
- 📊 Résultats : http://localhost:5001

### 4. Voir les logs si un service pose problème
```bash
docker-compose logs -f
```

---


## 🐳 Déploiement avec Docker Swarm

Après validation en local, l'application a été déployée sur un cluster Docker Swarm.

### 1. Initialisation du cluster

Sur le noeuds manager :
```bash
docker swarm init
```

Cette commande a fourni un **token d’accès** permettant de rejoindre le cluster depuis d’autres nœuds :
```bash
docker swarm join --token <TOKEN> <IP_MANAGER>:2377
```

Les autres noeuds worker ont rejoint le cluster avec cette commande.

### 2. Mise à disposition des images

Les images ont été **buildées localement** puis **poussées sur Docker Hub** afin d’être accessibles depuis tous les nœuds du cluster :

```bash
docker build -t <utilisateur_dockerhub>/vote ./vote
docker build -t <utilisateur_dockerhub>/worker ./worker
docker build -t <utilisateur_dockerhub>/result ./result

docker push <utilisateur_dockerhub>/vote
docker push <utilisateur_dockerhub>/worker
docker push <utilisateur_dockerhub>/result
```

### 3. Déploiement de la stack

Une fois les images disponibles, le déploiement a été effectué à l’aide du fichier `docker-stack.yml` :

```bash
docker stack deploy -c docker-stack.yml 3dokr
```

### 4. Suivi et vérification

Vérification des services Swarm :
```bash
docker service ls
```

Accès aux interfaces (depuis n’importe quel nœud du cluster) :
- Vote : `http://<IP_DU_NOEUD>:5000`
- Résultats : `http://<IP_DU_NOEUD>:5001`

---

## 🧼 Nettoyage

Pour arrêter et nettoyer :

### Docker Compose :
```bash
docker-compose down
```

### Docker Swarm :
```bash
docker stack rm 3dokr
```
