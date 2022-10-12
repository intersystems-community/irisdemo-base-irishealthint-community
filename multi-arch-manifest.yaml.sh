image: ${DOCKER_REPO}:latest
manifests:
  - image: ${DOCKER_REPO}:amd64
    platform:
      architecture: amd64
      os: linux
  - image: ${DOCKER_REPO}:arm64v8
    platform:
      architecture: arm64
      os: linux
      variant: v8