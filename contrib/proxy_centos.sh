#!/bin/bash
#
# configure a proxy when http_proxy is defined on the system
#
parse_ip() {
  echo $1 | sed -nE "s/^(http(s)?:\/\/)?((.+):(.+)@)?(.+):([0-9]+)\/?$/\6/p"
}

parse_port() {
  echo $1 | sed -nE "s/^(http(s)?:\/\/)?((.+):(.+)@)?(.+):([0-9]+)\/?$/\7/p"
}

parse_login() {
  echo $1 | sed -nE "s/^(http(s)?:\/\/)?((.+):(.+)@)?(.+):([0-9]+)\/?$/\4/p"
}

parse_password() {
  echo $1 | sed -nE "s/^(http(s)?:\/\/)?((.+):(.+)@)?(.+):([0-9]+)\/?$/\5/p"
}

remove_auth() {
  echo $1 | sed -nE "s/^(http(s)?:\/\/)?((.+):(.+)@)?(.+):([0-9]+)\/?$/\1\6:\7/p"
}

set_proxy() {

    local http_proxy=$1

    echo "export proxy vars"
    export http_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export no_proxy=localhost,127.0.0.1,10.0.0.0/16
    local http_proxy_noauth=$(remove_auth $http_proxy)
    local login=$(parse_login $http_proxy)
    local password=$(parse_password $http_proxy)

   
}

clear_proxy() {
    echo "clear proxy settings"

    unset PROXY
    unset http_proxy
    unset HTTP_PROXY
    unset no_proxy
}

# MAIN
if [ ! -z "$http_proxy" ] &&  [ ! "$http_proxy" = '"nil"' ]; then
    set_proxy $http_proxy
else
    clear_proxy
fi

# for debug only
# env
