#!/usr/bin/env bashio
# shellcheck shell=bash disable=SC2155,SC2068

# if a param has been passed, then just run it
test "$#" -gt 0 && exec $@

# Start Periphery

LOG_LEVEL=$(bashio::config "log_level" "info")
bashio::log.level "${LOG_LEVEL}"
export PERIPHERY_LOGGING_LEVEL="${LOG_LEVEL}"
bashio::log.debug "Log level set to ${LOG_LEVEL}"

bashio::log.debug "$(bashio::app.protected)"

bashio::log.info "$(date) Updating CA Certificates"

bashio::log.debug "$(/usr/sbin/update-ca-certificates)"

bashio::log.info "Setting up Periphery config"

# core_address and connect_as are required
bashio::config.require "core_address"
bashio::config.require "connect_as"

export PERIPHERY_CORE_ADDRESS=$(bashio::config "core_address")
bashio::log.debug "PERIPHERY_CORE_ADDRESS=${PERIPHERY_CORE_ADDRESS}"

export PERIPHERY_CONNECT_AS=$(bashio::config "connect_as")
bashio::log.debug "PERIPHERY_CONNECT_AS=${PERIPHERY_CONNECT_AS}"

if bashio::config.has_value "onboarding_key" ; then
  export PERIPHERY_ONBOARDING_KEY=$(bashio::config "onboarding_key")
  bashio::log.debug "PERIPHERY_ONBOARDING_KEY=${PERIPHERY_ONBOARDING_KEY//[A-Za-z0-9]/x}"
fi

export PERIPHERY_ROOT_DIRECTORY="/mnt/data/supervisor/share/komodo"
bashio::log.debug "root directory=${PERIPHERY_ROOT_DIRECTORY}"

if bashio::config.true "disable_terminals" ; then
  export PERIPHERY_DISABLE_TERMINALS="true"
  bashio::log.debug "PERIPHERY_DISABLE_TERMINALS=${PERIPHERY_DISABLE_TERMINALS}"
fi

if bashio::config.true "disable_container_terminals" ; then
  export PERIPHERY_DISABLE_CONTAINER_TERMINALS="true"
  bashio::log.debug "PERIPHERY_DISABLE_CONTAINER_TERMINALS=${PERIPHERY_DISABLE_CONTAINER_TERMINALS}"
fi

export PERIPHERY_INCLUDE_DISK_MOUNTS=$(bashio::config "include_disk_mounts" "/")
bashio::log.debug "PERIPHERY_INCLUDE_DISK_MOUNTS=${PERIPHERY_INCLUDE_DISK_MOUNTS}"

if bashio::config.has_value "exclude_disk_mounts" ; then
  export PERIPHERY_EXCLUDE_DISK_MOUNTS=$(bashio::config "exclude_disk_mounts" "")
  bashio::log.debug "PERIPHERY_EXCLUDE_DISK_MOUNTS=${PERIPHERY_EXCLUDE_DISK_MOUNTS}"
fi

export PERIPHERY_PRIVATE_KEY="file:/data/keys/periphery.key"
bashio::log.debug "PERIPHERY_PRIVATE_KEY=${PERIPHERY_PRIVATE_KEY}"
export PERIPHERY_CORE_PUBLIC_KEYS="file:/data/keys/core.pub"
bashio::log.debug "PERIPHERY_CORE_PUBLIC_KEYS=${PERIPHERY_CORE_PUBLIC_KEYS}"

bashio::log.debug "Creating ${PERIPHERY_ROOT_DIRECTORY}"
mkdir -p "${PERIPHERY_ROOT_DIRECTORY}"
# bashio::log.info "Listing parent of root directory (root=${PERIPHERY_ROOT_DIRECTORY})"
# ls -aR "${PERIPHERY_ROOT_DIRECTORY}/"
bashio::log.debug "Creating /data/keys"
mkdir -p /data/keys
# bashio::log.info "Listing /data..."
# ls -aR /data

# the supervisor exposes the docker socket at /run
export DOCKER_HOST="unix:///run/docker.sock"

bashio::log.info "Connecting ${PERIPHERY_CORE_ADDRESS} as ${PERIPHERY_CONNECT_AS}"

exec /usr/local/bin/periphery
