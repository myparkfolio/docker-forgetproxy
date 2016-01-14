#!/bin/bash
#
# configure a proxy when http_proxy is defined on the system
#
if [ ! -z "$http_proxy" ] &&  [ ! "$http_proxy" = '"nil"' ]; then
    echo "setting up proxy"

    if [ -z "$https_proxy"  ] && [ ! "$https_proxy" = '"nil"' ]; then
         https_proxy=$http_proxy
    else 
         https_proxy=
    fi

    echo "export proxy vars"
    export http_proxy=$http_proxy
    export https_proxy=$https_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$https_proxy
    export ftp_proxy=$(echo $http_proxy | sed 's/^http/ftp/g')
    export socks_proxy=$(echo $http_proxy | sed 's/^http/socks/g')
    export no_proxy=localhost,127.0.0.1,10.0.0.0/16

    if [ "$(id -u)" = "0" ] ; then # should only be done by root
      echo "configure apt proxy"
      # clear out previous setting
      [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf | grep -v '::proxy' > /etc/apt/apt.conf

      # reset the apt.conf
      cat >> /etc/apt/apt.conf <<APT_CONF
Acquire::http::proxy "${http_proxy}";
Acquire::https::proxy "${http_proxy}";
Acquire::ftp::proxy "${ftp_proxy}";
Acquire::socks::proxy "${socks_proxy}";
APT_CONF
    fi
else
    echo "skiping proxy settings"

    unset PROXY
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset ftp_proxy
    unset socks_proxy
    unset no_proxy

    if [ "$(id -u)" = "0" ] ; then # should only be done by root
        [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf | grep -v '::proxy' > /etc/apt.conf
    fi
fi

# for debug only
# env
