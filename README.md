# props to / based upon 

https://github.com/AGhost-7/docker-dev

Head over there for various focused dev environments and some tips in the README.md for making clipboard work in case it doesn't out of the box.

# description

I was looking for an ephermal (so docker-based) nvim dev environment for javascript, python and go that I could use both via remote as well as local development. I wanted something that I can  easiliy share with team-members and use on many devices, when I found AGhost's work.
Maybe it is not smart but I wanted to combine the three different languages and toolsets in one container so this is what we have got here.

# status

It was tested and works reasonably well for JS development remote via OSX/iterm2/ssh and also when host and client are on the same machine without ssh. The go-part is not tested, the python-part not begun, the build structure is messy.

# build & usage prerequisites

1. You need a docker host on Linux basis (only tested on Ubuntu 18.04 so far with upstream docker, not the dist package)
2. For the client-side, on OSX I recommend iterm2 so that OSC 52 clipboard-"sharing" may work

# how to build

1. git clone this repo
2. Modify the bin/start_container.sh to include the files and folders in the mounting that you need.
3. `sudo apt-get install build-essential` in case you don't have it yet
4. `make build`
5. make coffee
6. add the lines in `.bashrc_host.dist` to the .bashrc or .bash_aliases on the docker-host for convenient starting and attaching to your dev-terminal. Change the paths so they point to the repo and reload the .bashrc via `source ~/.bashrc` 
7. start and attach via `envstart && envattach`

# example workflow

1. log in via ssh to your remote host
2. attach via `envattach` (optional `envstart`) to the running container.
3. work on your workspaces/whatever you do.
4. Use the `gc` command for a nice two-windows commit mode
5. When your work is done, leave the container via docker ctrl-p ctrl-q
6. come back any time with `envattach`
7. If you want to reboot your host from time to time or restart the container, consider saving the nvim session in a folder that is mounted. 

# known issues & notes

- the username within the environment will be the same as the onethat you build the container with.

