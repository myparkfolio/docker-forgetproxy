FROM centos:centos7

ENV http_proxy ${http_proxy:-nil}
ENV https_proxy ${https_proxy:-nil}

# Allow to manage proxy initialisation
# @todo Beware proxy login/password write in config file, remove it
COPY contrib/proxy_debian.sh /etc/profile.d/

RUN . /etc/profile \
    && yum install -y \
        iptables \
        procps \
        psmisc \
        squid \
        nc \
    && clear_proxy

ADD squid.conf /etc/squid/squid.conf
ADD squid /root/

# Make cache dirs 
RUN squid -z -F

EXPOSE 3128

ENTRYPOINT ["/bin/bash", "/root/squid"]

