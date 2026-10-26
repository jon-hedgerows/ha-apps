ARG BUILD_FROM
FROM ghcr.io/moghtech/komodo-periphery:2

RUN apt-get update && apt-get install -y --no-install-recommends jq && rm -rf /var/lib/apt/lists/*

COPY run.sh /
RUN chmod a+x /run.sh

LABEL \
  io.hass.version="0.0.2" \
  io.hass.type="app" \
  io.hass.arch="aarch64|amd64"

CMD [ "/run.sh" ]
