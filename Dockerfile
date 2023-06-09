ARG DEBIAN_VERSION=9
FROM debian:${DEBIAN_VERSION}

ARG BUILD_DATE
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-url="https://github.com/tatsuryu/debian-systemd"

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN \
    --mount=type=cache,target=/var/cache/apt \
    apt-get update \
    && apt-get install -y python3 sudo bash ca-certificates iproute2 equivs \
    && apt-get install -y systemd python3-pip\
    && apt-get clean && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "exit 0" > /usr/sbin/policy-rc.d \
    && ln -s /lib/systemd/systemd /sbin/init || true

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]
