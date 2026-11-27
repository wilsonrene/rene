#!/usr/bin/env bash
set -e

# Configuration du projet
IMAGE_NAME="rene-web"
CONTAINER_NAME="rene-web-container"
HOST_PORT="8090"
CONTAINER_PORT="80"

echo "=================================="
echo "   DEPLOIEMENT DU PROJET RENE"
echo "=================================="

echo "=== Construction de l'image Docker ==="
docker build -t "$IMAGE_NAME" .

echo "=== Nettoyage de l'ancien conteneur ==="
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "=== Demarrage du conteneur ==="
docker run -d \
    --name "$CONTAINER_NAME" \
    -p "$HOST_PORT:$CONTAINER_PORT" \
    --restart unless-stopped \
    "$IMAGE_NAME"

echo "=== Verification du conteneur ==="
docker ps --filter "name=$CONTAINER_NAME"

echo "=================================="
echo "Projet Rene deploye avec succes !"
echo "URL : http://localhost:$HOST_PORT"
echo "=================================="
