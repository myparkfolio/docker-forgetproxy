#!/usr/bin/env sh

docker build -t myparkfolio/docker-forgetproxy --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy .
