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
echo
echo "press Control+C to stop proxy and quit"
docker run -ti --rm --name proxy --net=host --privileged -e http_proxy=$http_proxy myparkfolio/docker-forgetproxy
