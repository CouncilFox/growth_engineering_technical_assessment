#!/usr/bin/env bash

set -e  # Exit on error

# Determine script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

IMAGE="ttl.sh/growth-engineering:2h"
MANIFEST="$SCRIPT_DIR/../app/manifest.yaml"

# Color codes
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
MAGENTA="\e[1;35m"
CYAN="\e[1;36m"
RESET="\e[0m"

print_separator() {
  echo -e "${MAGENTA}------------------------------------------------------------${RESET}"
}

clear
echo -e "${BLUE}Starting Deployment...${RESET}"
print_separator

echo -e "${CYAN}Step 1: Building Docker Image...${RESET}"
docker build -t $IMAGE "$SCRIPT_DIR/../app"
echo -e "${GREEN}Image built successfully.${RESET}\n"
print_separator

echo -e "${CYAN}Step 2: Pushing Image to ttl.sh...${RESET}"
docker push $IMAGE
echo -e "${GREEN}Image pushed successfully.${RESET}\n"
print_separator

echo -e "${CYAN}Step 3: Applying Kubernetes Manifests...${RESET}"
kubectl apply -f $MANIFEST
echo -e "${GREEN}Manifests applied successfully.${RESET}\n"
print_separator

echo -e "${YELLOW}Waiting for Pods to become ready...${RESET}"
kubectl wait --for=condition=ready pod -l app=growth-engineering --timeout=90s
echo -e "${GREEN}Pods are ready!${RESET}\n"
print_separator

echo -e "${YELLOW}Checking service health...${RESET}"
kubectl port-forward svc/growth-engineering-service 8080:8080 &> /dev/null &
PORT_FWD_PID=$!
sleep 2  # Give port-forward time to establish

HEALTH=$(curl -s http://localhost:8080/healthz)
kill $PORT_FWD_PID

if [ "$HEALTH" == "ok" ]; then
    echo -e "${GREEN}Service is healthy and ready!${RESET}\n"
else
    echo -e "${RED}Service did not report healthy status. Check logs for details.${RESET}\n"
fi
print_separator

echo -e "${BLUE}Deployment complete!${RESET}"
echo -e "Access the service at: ${CYAN}http://localhost:8080${RESET}\n"
echo -e "When done, run ${YELLOW}'./scripts/teardown.sh'${RESET} to remove the environment."
echo
