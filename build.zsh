#!/usr/bin/env zsh

# this script builds images locally, reflecting what the github workflow does

repo="jon-hedgerows/ha-apps"

for app in $(find . -type d -maxdepth 1 -not -path '*/.*' | sed 's#./##') ; do
  echo "Building ${app}"
  taglatest=ghcr.io/${repo}-${app}:latest
  tagsemver=ghcr.io/${repo}-${app}:$(git describe --tags | sed 's/^v//')
  tagsemvermajorminor=ghcr.io/${repo}-${app}:$(git describe --tags | sed 's/^v//' | cut -f1-2 -d.)
  tagsemvermajor=ghcr.io/${repo}-${app}:$(git describe --tags | sed 's/^v//' | cut -f1 -d.)
  
  docker buildx build --build-arg VERSION="${tagsemver}" --file "./${app}/Dockerfile" --tag "${taglatest}" --tag "${tagsemver}" --tag "${tagsemvermajorminor}" --tag "${tagsemvermajor}" ./${app}
done
