#!/usr/bin/env zsh

# this script builds images locally, reflecting what the github workflow does

repo="jon-hedgerows/ha-apps"

for app in *(/) ; do
  echo "Building ${app}"
  version=$(awk '/^version: / {gsub(/"/, "", $2); print $2}' ${app}/config.yaml)
  taglatest="ghcr.io/${repo}-${app}:latest"
  tagsemver="ghcr.io/${repo}-${app}:${version}"
  tagsemvermajorminor="ghcr.io/${repo}-${app}:${version%.*}"
  tagsemvermajor="ghcr.io/${repo}-${app}:${version%%.*}"
  
  docker buildx build --build-arg VERSION="${tagsemver}" --file "./${app}/Dockerfile" --tag "${taglatest}" --tag "${tagsemver}" --tag "${tagsemvermajorminor}" --tag "${tagsemvermajor}" ./${app}
done
