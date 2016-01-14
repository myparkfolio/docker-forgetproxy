FROM debian:wheezy

ENV http_proxy ${http_proxy:-nil}
ENV https_proxy ${https_proxy:-nil}

# Allow to manage proxy initialisation
COPY contrib/proxy_debian.sh /etc/profile.d/

RUN . /etc/profile \
    && apt-get -q update \
    && apt-get -qy install \
        iptables \
        procps \
        psmisc \
        redsocks
    
ADD redsocks.conf /tmp/
ADD redsocks /root/

ENTRYPOINT ["/bin/bash", "/root/redsocks"]

