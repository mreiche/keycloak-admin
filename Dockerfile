FROM registry.access.redhat.com/ubi9 AS ubi-micro-build
ARG PACKAGES="jq curl"
RUN mkdir -p /mnt/rootfs
RUN dnf install --installroot /mnt/rootfs ${PACKAGES} --releasever 9 --setopt install_weak_deps=false --nodocs -y && \
    dnf --installroot /mnt/rootfs clean all && \
    rpm --root /mnt/rootfs -e --nodeps setup
COPY src/ /mnt/rootfs/usr/local/bin
RUN chmod +x /mnt/rootfs/usr/local/bin/*

FROM quay.io/keycloak/keycloak
COPY --from=ubi-micro-build /mnt/rootfs /
RUN jq --version
