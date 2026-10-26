ARG BUILD_FROM

FROM ghcr.io/moghtech/komodo-periphery:2

RUN apt-get update && apt-get install -y --no-install-recommends jq && rm -rf /var/lib/apt/lists/*

COPY run.sh /
RUN chmod a+x /run.sh

ARG VERSION="0.0.0"

LABEL \
  io.hass.version="${VERSION}" \
  io.hass.type="app" \
  io.hass.arch="aarch64|amd64"

CMD [ "/run.sh" ]
