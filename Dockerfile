FROM debian:buster-slim

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    BEAST_PORT=30005 \
    STATS_INTERVAL=5

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY rootfs/ /

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
  # S6 Install
  ca-certificates wget \
  # Required always
  bc procps socat tzdata \
  # Required for build
  binutils debhelper dirmngr git gnupg lsb-release netbase xz-utils \
  file build-essential python3 python3-dev && \
  chmod +x /scripts/*.sh && \
  chmod +x /healthcheck.sh && \
  # i386 & amd64 specific
  /scripts/get-qemu.sh && \
  # Import GPG key for the APT repository
  KEY_ID=1D043681 && \
  apt-key adv --recv-key --keyserver hkp://keyserver.ubuntu.com:80 ${KEY_ID} || \
  apt-key adv --recv-key --keyserver hkp://pool.sks-keyservers.net:80 ${KEY_ID} || \
  apt-key adv --recv-key --keyserver hkp://pgp.mit.edu:80 ${KEY_ID} && \
  # RadarBox Repository
  echo "deb https://apt.rb24.com/ buster main" > /etc/apt/sources.list.d/rb24.list && \
  # Arch Specific Operations
  /scripts/arch-specific.sh && \
  # S6 OVERLAY
  /scripts/s6-overlay.sh && \
  # MLAT Client
  git clone https://github.com/mutability/mlat-client.git /src/mlat-client && \
  pushd /src/mlat-client && \
  BRANCH_MLAT_CLIENT=$(git tag --sort="-creatordate" | head -1) && \
  git checkout "$BRANCH_MLAT_CLIENT" && \
  ./setup.py install && \
  popd && \
  # Cleanup
  apt-get remove -y binutils debhelper build-essential file git dirmngr gnupg \
  python3-dev xz-utils && \
  apt-get autoremove -y && \
  rm -rf /scripts /src /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
EXPOSE 30105
HEALTHCHECK --start-period=120s --interval=300s CMD /healthcheck.sh
LABEL maintainer="Jeremie-C <Jeremie-C@users.noreply.github.com>"
