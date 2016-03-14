#!/usr/bin/env sh

docker run -ti --rm --name proxy --net=host --privileged -e http_proxy=$http_proxy myparkfolio/docker-forgetproxy
