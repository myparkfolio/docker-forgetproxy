# docker-forgetproxy

A transparent http with auth proxy (via socks) for Docker.

If you are running Docker behind a corporate http proxy, you probably know how annoying it is
having to configure the proxy in every container.

You can run this container instead to just forget it and let docker run as if you had a direct connection
to the outside world.

This container is based on the [munkyboy / redsocks](https://registry.hub.docker.com/u/munkyboy/redsocks/) one and the squid proxy https://github.com/akram/docker-squid.
It runs entirely from inside the container.


## Disclaimer 

**/!\ BEWARE! THIS CONTAINER MODIFIES THE IPTABLES RULES FOR THE docker0 INTERFACE ON THE HOST MACHINE!!!**
**PLEASE READ THE EXPLANATIONS BELOW AND MAKE SURE TO EXIT IT CLEANLY OR TO RUN THE STOP COMMAND TO RESET YOUR RULES**


## How it works

All hhtp network connections coming out of the docker0 interface will automatically be proxified.

The container interprets the environment variables http_proxy to configure the squid proxy. For parkeon users, you can unset your http_proxy environment variable and then during launching of this proxy, it will ask for your password and forge proxy url


## What's new

This project has been forked to managed ldap authentication with a login and a password in the proxy url.

Two build helpers files was added:
 * build.sh => allow to build docker (with environment configuration )
 * run.sh => allow to run docker (like the start command)

The only thing you should think about is to configure your environment proxy http_proxy (or being a parkeon users) and the scripts would do the rest.


## How to use it

### build

    with http_proxy defined in your env : docker build -t myparkfolio/docker-forgetproxy --build-arg http_proxy=$http_proxy .

First step is to build the project if it is not already done.

### start

     docker run -ti --net=host --privileged -e http_proxy=$http_proxy myparkfolio/docker-forgetproxy

It is recommended to let the container run in the foreground as it is configured to intercept the CTRL+C and clean
the iptables rules on exit.

Manage http on port 3128, https is not supported.

### stop

If you have your container running, just press CTRL+C.
If you need to manually clean the iptables rules that are set by the container, you can run the following command
until you get an error telling you the rules do no exist.

    docker run -ti --net=host --privileged myparkfolio/docker-forgetproxy stop
