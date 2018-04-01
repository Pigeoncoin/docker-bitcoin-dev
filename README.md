# pigeon-dev Docker Images

Building and developing Pigeoncoin in docker containers.

# Requirements

* Docker 1.2+
* An X11 socket (for IDEs)

# Dockerfiles

* This directory: an image containing all the build dependencies required to build Pigeoncoin from source.
* /netbeans: an image with netbeans C++ tools (inspired by [fgrehm/docker-netbeans](https://registry.hub.docker.com/u/fgrehm/netbeans/)).
* /eclipse: an image with Eclipse C++ tools

# Building
In order to build Pigeoncoin, assuming you are in a folder where you want to clone both this repo and the pigeoncoin repo
```
git clone https://github.com/Pigeoncoin/pigeoncoin.git
git clone https://github.com/Pigeoncoin/docker-pigeon-dev
cd docker-pigeon-dev
```

Move on to either building Windows or Linux binaries (or both)

## Build Windows binarires
### Build container
Building the container only needs to be done once per system (assuming depedencies do not change). New branches or edits can be built without rebuilding the container.

From the docker-pigeon-dev directory:
```
sudo docker build . -f Dockerfile.windows -t pigeon-dev-windows
sudo docker run -ti -v `pwd`/../pigeoncoin:/pigeoncoin pigeon-dev-windows
```
You will be in the container shell after executing these commands.
### Build .exe
In the container shell, run the following:

```
PATH=$(echo "$PATH" | sed -e 's/:\/mnt.*//g') # strip out problematic Windows %PATH% imported var
cd depends
make HOST=x86_64-w64-mingw32
cd ..
./autogen.sh # not required when building from tarball
CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --prefix=/
make
```

The two ```make``` commands will take a very long time to complete on most systems. 

This will result in the Windows .exe in ../pigeoncoin/src (where the pigeoncoin repo got cloned to)-
* src/pigeond.exe
* src/pigeon-cli.exe
* src/pigeon-tx.exe
* src/qt/pigeon-qt.exe

## Build Linux binaries
### Build container
Building the container only needs to be done once per system (assuming depedencies do not change). New branches or edits can be built without rebuilding the container.

From the docker-pigeon-dev directory:
```
sudo docker build . -f Dockerfile.linux -t pigeon-dev-linux
sudo docker run -ti -v `pwd`/../pigeoncoin:/pigeoncoin pigeon-dev-linux
```
You will be in the container shell after executing these commands.

### Build binaries
In the container shell, run the following:

```
./autogen.sh
./configure --enable-cxx --disable-shared --with-pic CXXFLAGS="-fPIC -O" CPPFLAGS="-fPIC -O"
make
```

This will result in the Linux executables in ../pigeoncoin/src (where the pigeoncoin repo got cloned to)-
* src/pigeond
* src/pigeon-cli
* src/pigeon-tx
* src/qt/pigeon-qt

# Running IDEs
TODO
