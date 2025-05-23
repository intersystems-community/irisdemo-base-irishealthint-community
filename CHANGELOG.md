## 1.14.0 (May 14, 2025)
  - upgrading to IRIS 2025.1 community

## 1.13.0 (May 23, 2024)
  - Upgrading to IRIS 2024.1

## 1.12.5 (June 21, 2023)
  - Disabling building for ARM because of issue related to absense of /bin/sh

## 1.12.4 (June 21, 2023)
  - Fixing issue with /bin/sh that would prevent us from building the ARM image on docker hub.

## 1.12.3 (June 21, 2023)
  - Fixing issue with /bin/sh that would prevent us from building the ARM image on docker hub.

## 1.12.2 (June 20, 2023)
  - bumping to IRIS 2023.2.0

## 1.12.1 (June 20, 2023)


## 1.12.0 (June 14, 2023)
  - Bumping IRIS version to 2023.2

## 1.11.7 (October 20, 2022)
  - Bumping IRIS version to 2022.1.0.209.0-zpm
  - Adding missing #!/bin/bash to irisdemoinstaller.sh
  - Adding push scripts.

## 1.11.6 (October 18, 2022)
  - Upgrading QEMU to 7.0.0

## 1.11.5 (October 18, 2022)
  - Upgrading QEMU to 7.0.0

## 1.11.4 (October 18, 2022)
  - Adding support for ARM

## 1.11.3 (October 12, 2022)
  - Changing build script to use "docker buildx" instead of "docker build" so we can build images for both x86 and ARM

## 1.11.2 (October 06, 2022)
  - Adding dummy Dockerfile so that docker hub will accept this and build both images for us.

## 1.11.1 (October 06, 2022)
  - Adding support for ARM processors.

## 1.11.0 (May 18, 2022)
  - Bumping the version of IRIS to 2022.1.0.191.0

## 1.10.3 (January 25, 2022)
  - Bumping IRIS version to 2021.2.0.649.0

## 1.10.2 (December 30, 2021)
  - Can not remove messages.log or IRIS will not start anymore.

## 1.10.1 (December 22, 2021)
  - Solving non-root issues related to IRIS 2021.2.0.619
  - Bumping base iris to IRIS 2021.2.0.619

## 1.8.0 (December 21, 2021)
  - Bumping base iris to IRIS 2021.2.0.619
  - Adding --init to example on README.md
  - Fixing bumpversion.sh

## 1.7.1 (March 30, 2020)
  - Based on IRIS 2020.1.0.209.0

## 1.6.3 (November 15, 2019)
  - Based now on IRIS for Health Community 2019.4
  - Adding Docker Autobuild custom hooks

## 1.5 
  - Based on IRIS Community 2019.3

