#!/bin/bash
set -euo pipefail

echo "[INFO] Starting full cleanup..."

echo "[ACTION] Removing stopped containers..."
docker container prune -f

echo "[ACTION] Removing dangling Docker images..."
docker image prune -a -f

echo "[ACTION] Pruning unused networks..."
docker network prune -f

echo "[INFO] Stopped containers:"
docker ps -a -f status=exited

echo "[INFO] Dangling images:"
docker images -f dangling=true

echo "[INFO] Cleanup complete."
