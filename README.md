# pigeon-dev Docker Images

Building and developing Pigeoncoin in docker containers.

# Requirements

* Docker 1.2+
* An X11 socket (for IDEs)

# Dockerfiles

* This directory: an image containing all the build dependencies required to build Pigeoncoin from source.
* /netbeans: an image with netbeans C++ tools (inspired by [fgrehm/docker-netbeans](https://registry.hub.docker.com/u/fgrehm/netbeans/)).
* /eclipse: an image with Eclipse C++ tools

# Quickstart
In order to build Pigeoncoin, assuming you are in a folder where you want to clone both this repo and the pigeoncoin repo
```
git clone https://github.com/Pigeoncoin/pigeoncoin.git
git clone https://github.com/Pigeoncoin/docker-pigeon-dev
cd docker-pigeon-dev
sudo docker build . -t pigeon-dev
sudo docker run -ti -v `pwd`/../pigeoncoin:/pigeoncoin pigeon-dev
```

Once the container has started and you are dropped into its shell, execute:
```
./autogen.sh
./configure --enable-cxx --disable-shared --with-pic CXXFLAGS="-fPIC -O" CPPFLAGS="-fPIC -O"
make
```
This will result in the Linux executables in ../pigeoncoin/src (where the pigeoncoin repo got cloned to)

TODO: Cross compilation
# Running IDEs
TODO
