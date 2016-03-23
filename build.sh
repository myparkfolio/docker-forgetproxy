#!/usr/bin/env sh
if [ -z "$http_proxy" ] ; then
    trap "stty echo" INT TERM QUIT
	echo -n "Password: "
	stty -echo
	read PASSWORD
	stty echo
	u="$USER"
	http_proxy=http://$u:$PASSWORD\@proxy.parkeon.com:9090/
fi
docker build -t myparkfolio/docker-forgetproxy --build-arg http_proxy=$http_proxy .
