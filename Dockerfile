FROM debian:wheezy

ENV http_proxy ${http_proxy:-nil}
ENV https_proxy ${https_proxy:-nil}

# Allow to manage proxy initialisation
# @todo Beware proxy login/password write in config file, remove it
COPY contrib/proxy_debian.sh /etc/profile.d/

RUN . /etc/profile \
    && apt-get update \
    && apt-get -y install \
        iptables \
        procps \
        psmisc \
        redsocks \
    && clear_proxy

ADD redsocks.conf /tmp/
ADD redsocks /root/

ENTRYPOINT ["/bin/bash", "/root/redsocks"]

