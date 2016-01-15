# docker-forgetproxy

A transparent socks proxy for Docker.

If you are running Docker behind a corporate http proxy, you probably know how annoying it is
having to configure the proxy in every container.

You can run this container instead to just forget it and let docker run as if you had a direct connection
to the outside world.

This container is based on the [munkyboy / redsocks](https://registry.hub.docker.com/u/munkyboy/redsocks/) one.
It runs entirely from inside the container.


## Disclaimer 

**/!\ BEWARE! THIS CONTAINER MODIFIES THE IPTABLES RULES FOR THE docker0 INTERFACE ON THE HOST MACHINE!!!**
**PLEASE READ THE EXPLANATIONS BELOW AND MAKE SURE TO EXIT IT CLEANLY OR TO RUN THE STOP COMMAND TO RESET YOUR RULES**


## How it works

All network connections coming out of the docker0 interface will automatically be proxified.

The container  interprets the environment variables http_proxy and https_proxy to configure the socks proxy. 


## How to use it

### start

    docker run -ti --net=host --privileged -e http_proxy=http://myproxy:3128 -e https_proxy=http://myproxy:3128 klabs/forgetproxy

It is recommended to let the container run in the foreground as it is configured to intercept the CTRL+C and clean
the iptables rules on exit.

### stop

If you have your container running, just press CTRL+C.
If you need to manually clean the iptables rules that are set by the container, you can run the following command
until you get an error telling you the rules do no exist.

    docker run --net=host --privileged klabs/forgetproxy stop

## What's new

This project has been forked to managed ldap authentication with a login and a password in the proxy url.

Two build helpers files was added:
 * build.sh => allow to build docker (with proxy apt, wget, environment configuration)
 * run.sh => allow to run docker (like the start command)

The only thing you should think about is to configure your environment proxy http_proxy and https_proxy and the scripts would do the rest.

Beware if you run docker with sudo to use "sudo -E" in order to propagate your current environment variables.
 
