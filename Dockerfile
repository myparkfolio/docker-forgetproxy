FROM centos:centos7

ENV http_proxy ${http_proxy:-nil}
ENV https_proxy ${https_proxy:-nil}

# Allow to manage proxy initialisation
COPY contrib/proxy_debian.sh /etc/profile.d/

RUN . /etc/profile \
    && yum install -y \
        iptables \
        procps \
        psmisc \
        squid \
        nc \
    && clear_proxy

COPY squid.conf /etc/squid/squid.conf
COPY squid /root/

# Make cache dirs 
RUN squid -z -F

EXPOSE 3128

ENTRYPOINT ["/bin/bash", "/root/squid"]

