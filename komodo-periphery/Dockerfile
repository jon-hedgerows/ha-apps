### Configuration ARGs
# origin of the periphery binary
ARG PERIPHERY_VERSION=2.3.4
ARG PERIPHERY_IMAGE=ghcr.io/moghtech/komodo-periphery:${PERIPHERY_VERSION}
ARG DEBIAN_RELEASE=trixie
ARG BASHIO_VERSION=0.19.0

###
# pull in periphery

FROM ${PERIPHERY_IMAGE}

# Build arguments
ARG DEBIAN_RELEASE
ARG TARGETARCH
ARG BUILD_ARCH=${TARGETARCH}
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
ARG BASHIO_VERSION

### Add bashio from e.g. https://github.com/hassio-addons/bashio/archive/v0.19.0.tar.gz
ADD --unpack=true "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" /usr/src/bashio
WORKDIR /usr/src/bashio
RUN \
  mv /usr/src/bashio/bashio-*/lib /usr/lib/bashio \
  && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
  && rm -rf /usr/src/bashio
WORKDIR /
# bashio depends on jq
RUN apt-get update \
  && apt-get install -y --no-install-recommends jq

# Add Docker's official GPG key, repo, and install docker cli (not docker-ce daemon or containerd)
RUN apt-get install -y --no-install-recommends ca-certificates curl \
  && install -m 0755 -d /etc/apt/keyrings \
  && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
  && chmod a+r /etc/apt/keyrings/docker.asc \
  && echo "Types: deb" | tee /etc/apt/sources.list.d/docker.sources \
  && echo "URIs: https://download.docker.com/linux/debian" | tee -a /etc/apt/sources.list.d/docker.sources \
  && echo "Suites: ${DEBIAN_RELEASE}"  | tee -a /etc/apt/sources.list.d/docker.sources \
  && echo "Components: stable" | tee -a /etc/apt/sources.list.d/docker.sources \
  && echo "Architectures: ${TARGETARCH}" | tee -a /etc/apt/sources.list.d/docker.sources \
  && echo "Signed-By: /etc/apt/keyrings/docker.asc" | tee -a /etc/apt/sources.list.d/docker.sources \
  && cat /etc/apt/sources.list.d/docker.sources \
  && apt-get update \
  && apt-get install -y --no-install-recommends docker-ce-cli docker-buildx-plugin docker-compose-plugin \
  && apt-get clean && rm -rf /var/lib/apt/lists/*. \
  && true

# Labels
LABEL \
  komodo.skip="true" \
  io.hass.name="${BUILD_NAME}" \
  io.hass.description="${BUILD_DESCRIPTION}" \
  io.hass.arch="${BUILD_ARCH}" \
  io.hass.type="addon" \
  io.hass.version=${BUILD_VERSION} \
  org.opencontainers.image.title="${BUILD_NAME}" \
  org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
  org.opencontainers.image.vendor="https://github.com/jon-hedgerows" \
  org.opencontainers.image.authors="Jon Davies <jon@hedgerows.org.uk>" \
  org.opencontainers.image.licenses="Apache License 2.0" \
  org.opencontainers.image.url="https://github.com/jon-hedgerows/ha-apps" \
  org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
  org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.revision=${BUILD_REF} \
  org.opencontainers.image.version=${BUILD_VERSION}

# install the entrypoint script
COPY ./run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD []
