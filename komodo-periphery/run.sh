#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

if [ ! -f "$CONFIG_PATH" ]; then
  echo "[WARN] No options.json found, starting periphery with env vars only"
  exec periphery
fi

CORE_ADDRESS=$(jq -r '.core_address // empty' "$CONFIG_PATH")
CONNECT_AS=$(jq -r '.connect_as // empty' "$CONFIG_PATH")
ONBOARDING_KEY=$(jq -r '.onboarding_key // empty' "$CONFIG_PATH")
ROOT_DIRECTORY=$(jq -r '.root_directory // empty' "$CONFIG_PATH")
DISABLE_TERMINALS=$(jq -r '.disable_terminals // empty' "$CONFIG_PATH")
DISABLE_CONTAINER_TERMINALS=$(jq -r '.disable_container_terminals // empty' "$CONFIG_PATH")
INCLUDE_DISK_MOUNTS=$(jq -r '.include_disk_mounts // empty' "$CONFIG_PATH")

if [ -z "$CORE_ADDRESS" ]; then
  echo "[ERROR] core_address is required. Configure it in the add-on options."
  exit 1
fi

if [ -z "$CONNECT_AS" ]; then
  echo "[ERROR] connect_as is required. Configure it in the add-on options."
  exit 1
fi

export PERIPHERY_CORE_ADDRESS="$CORE_ADDRESS"
export PERIPHERY_CONNECT_AS="$CONNECT_AS"

if [ -n "$ONBOARDING_KEY" ]; then
  export PERIPHERY_ONBOARDING_KEY="$ONBOARDING_KEY"
fi

if [ -n "$ROOT_DIRECTORY" ]; then
  export PERIPHERY_ROOT_DIRECTORY="$ROOT_DIRECTORY"
else
  export PERIPHERY_ROOT_DIRECTORY="/data/komodo"
fi

if [ "$DISABLE_TERMINALS" = "true" ]; then
  export PERIPHERY_DISABLE_TERMINALS="true"
fi

if [ "$DISABLE_CONTAINER_TERMINALS" = "true" ]; then
  export PERIPHERY_DISABLE_CONTAINER_TERMINALS="true"
fi

if [ -n "$INCLUDE_DISK_MOUNTS" ]; then
  export PERIPHERY_INCLUDE_DISK_MOUNTS="$INCLUDE_DISK_MOUNTS"
fi

# if [ "$SSL_ENABLED" = "true" ]; then
#   export PERIPHERY_SSL_ENABLED="true"
# fi

# if [ -n "$PORT" ]; then
#   export PERIPHERY_PORT="$PORT"
# fi

export PERIPHERY_PRIVATE_KEY="file:/data/keys/periphery.key"
export PERIPHERY_CORE_PUBLIC_KEYS="file:/data/keys/core.pub"

mkdir -p "${PERIPHERY_ROOT_DIRECTORY}"
mkdir -p /data/keys

echo "[INFO] Starting Komodo Periphery"
echo "[INFO] Connecting to: ${PERIPHERY_CORE_ADDRESS}"
echo "[INFO] As server: ${PERIPHERY_CONNECT_AS}"

update-ca-certificates

exec periphery