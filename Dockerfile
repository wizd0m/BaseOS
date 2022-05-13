FROM ubuntu:latest

RUN set -eux; \
        apt-get update && apt-get install -y --no-install-recommends \
        vim \
        openssh-server \
        openssl \
        tree \
        wget \
        curl \
    && apt-get clean && rm -rf /var/lib/apt/list/* /tmp/* /var/tmp/*

CMD ["bash"]