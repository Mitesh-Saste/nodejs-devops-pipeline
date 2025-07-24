#!/bin/bash

# Strict mode
set -euo pipefail

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}[INFO] Starting full cleanup...${NC}"

### 1. Docker Cleanup

echo -e "${YELLOW}[ACTION] Removing dangling Docker images...${NC}"
if docker images -f "dangling=true" -q | grep .; then
  docker rmi $(docker images -f "dangling=true" -q)
  echo -e "${GREEN}[SUCCESS] Removed dangling Docker images.${NC}"
else
  echo -e "${GREEN}[INFO] No dangling Docker images found.${NC}"
fi

echo -e "${YELLOW}[ACTION] Pruning unused containers...${NC}"
docker container prune -f
echo -e "${GREEN}[SUCCESS] Unused containers pruned.${NC}"

echo -e "${YELLOW}[ACTION] Pruning unused networks...${NC}"
docker network prune -f
echo -e "${GREEN}[SUCCESS] Unused networks pruned.${NC}"

### 2. Terraform Cleanup

echo -e "${YELLOW}[ACTION] Cleaning up Terraform local files...${NC}"
find . -type d -name ".terraform" -exec rm -rf {} +
find . -type f \( -name "terraform.tfstate" -o -name "terraform.tfstate.backup" \) -delete
echo -e "${GREEN}[SUCCESS] Terraform files and folders removed.${NC}"

### 3. SSH Key Cleanup

KEY_DIR="./infra"

if [[ -d "${KEY_DIR}" ]]; then
  echo -e "${YELLOW}[ACTION] Deleting all .pem and .pub files in ${KEY_DIR}${NC}"
  find "${KEY_DIR}" -type f \( -name "devops-server-key" -o -name "devops-server-key.pub" \) -exec rm -v {} \;
  echo -e "${GREEN}[SUCCESS] All .pem and .pub files removed from ${KEY_DIR}.${NC}"
else
  echo -e "${YELLOW}[INFO] Directory ${KEY_DIR} not found. Skipping bulk key deletion.${NC}"
fi

echo -e "${GREEN}[INFO] All cleanup tasks completed successfully!${NC}"
