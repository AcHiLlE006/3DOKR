#!/bin/bash

echo "🔨 Construction des images Docker..."

docker build -t achi77/vote ./vote
docker build -t achi77/result ./result
docker build -t achi77/worker ./worker

echo "✅ Construction terminée."


# === Push des images Docker ===
echo "📤 Push des images vers Docker Hub..."

docker push achi77/vote
docker push achi77/result
docker push achi77/worker

echo "✅ Push terminé avec succès."
