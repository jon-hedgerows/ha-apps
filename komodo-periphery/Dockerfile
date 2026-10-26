# the Debian release used for both HA and periphery
ARG DEBIAN_RELEASE=trixie
# use the base-debian variant matching the Debian release
ARG HABASE=ghcr.io/home-assistant/base-debian:${DEBIAN_RELEASE}
# origin for the periphery binary
ARG PERIPHERY_IMAGE=ghcr.io/moghtech/komodo-periphery:2
# The build version, used for the io.hass.version label
ARG VERSION="0.0.0"

###

FROM ${PERIPHERY_IMAGE} AS periphery

FROM ${HABASE} AS base

# consume args
ARG TARGETARCH
ARG DEBIAN_RELEASE
ARG VERSION

# Add Docker's official GPG key, repo, and install docker cli (not docker-ce daemon or containerd)
RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates curl \
  && install -m 0755 -d /etc/apt/keyrings \
  && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
  && chmod a+r /etc/apt/keyrings/docker.asc \
  && echo "Types: deb" | tee /etc/apt/sources.list.d/docker.sources \
  && echo "URIs: https://download.docker.com/linux/debian" | tee -a /etc/apt/sources.list.d/docker.sources \
  && echo "Suites: ${DEBIAN_RELEASE}"  | tee -a /etc/apt/sources.list.d/docker.sources \
  && echo "Components: stable" | tee -a /etc/apt/sources.list.d/docker.sources \
  && echo "Architectures: ${TARGETARCH}" | tee -a /etc/apt/sources.list.d/docker.sources \
  && echo "Signed-By: /etc/apt/keyrings/docker.asc" | tee -a /etc/apt/sources.list.d/docker.sources \
  && apt-get update \
  && apt-get install -y --no-install-recommends docker-ce-cli docker-buildx-plugin docker-compose-plugin \
  && apt-get clean && rm -rf /var/lib/apt/lists/*. \
  && true

LABEL \
  komodo.skip="true" \
  org.opencontainers.image.title="Komodo Periphery" \
  org.opencontainers.image.description="Komodo Periphery packaged as a Home Assistant App" \
  org.opencontainers.image.source="https://github.com/jon-hedgerows/ha-apps" \
  org.opencontainers.image.licenses="Apache License 2.0"

# setup s6
COPY rootfs /

# install periphery
COPY --from=periphery /usr/local/bin/periphery /usr/bin/periphery
