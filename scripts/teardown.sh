#!/usr/bin/env bash
set -e

# Determine script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Paths now relative to script directory
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
echo -e "${BLUE}Starting Teardown...${RESET}"
print_separator

echo -e "${YELLOW}Removing Kubernetes resources...${RESET}"
kubectl delete -f "$MANIFEST"
echo -e "${GREEN}Teardown complete.${RESET}\n"
print_separator

echo -e "${BLUE}Environment cleaned up successfully!${RESET}"
echo -e "You can now safely close this session or redeploy with ${CYAN}'./scripts/deploy.sh'${RESET}."
echo
