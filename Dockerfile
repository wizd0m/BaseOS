FROM ubuntu:latest

#ADD start.sh /
ADD id_rsa.pub /root
RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    mkdir -m 700 -p /root/.ssh && \ 
    cat /root/id_rsa.pub >> /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys && \
    set -eux; \
        apt-get update && apt-get install -y --no-install-recommends \
        git \
        build-essential \
        make \
        net-tools \
        iputils-ping \
        vim \
        openssh-server \
        openssl \
        tree \
        wget \
        curl && \
#    && echo "root:root" | chpasswd \
    sed -i 's/prohibit-password/yes/' /etc/ssh/sshd_config && \
    sed -ri 's/#?PubkeyAuthentication\s.*$/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -ri 's/#?PasswordAuthentication\s.*$/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    mkdir -p /var/run/sshd  && \
    apt-get clean && rm -rf /var/lib/apt/list/* /tmp/* /var/tmp/* /root/id_rsa.pub
#    && chmod +x /start.sh

EXPOSE 22

#CMD ["/start.sh"]
#CMD ['/usr/sbin/sshd', '-D', '-o' ]
ENTRYPOINT ["/usr/sbin/sshd", "-D"]