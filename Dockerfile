FROM ubuntu:16.04
RUN apt-get update;\
	apt-get install -y \
		sudo \
		build-essential \
		libtool \
		autotools-dev \
		automake \
		ccache \
		pkg-config \
		libssl-dev \
		libboost-system-dev \
		libboost-filesystem-dev \
		libboost-chrono-dev \
		libboost-program-options-dev \
		libboost-test-dev \
		libboost-thread-dev \
		python3 \
		wget \
		bsdmainutils \
		libqrencode-dev \
		libqt5gui5 \
		libqt5core5a \
		libqt5dbus5 \
		qttools5-dev \
		qttools5-dev-tools \
		libprotobuf-dev \
		protobuf-compiler \
		git-core \
		gdb \
		libzmq3-dev \
		libevent-dev;\
	apt-get clean;\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD bdb.sh /tmp/
RUN sh /tmp/bdb.sh
RUN wget "http://miniupnp.tuxfamily.org/files/download.php?file=miniupnpc-1.6.tar.gz" -O miniupnpc-1.6.tar.gz;\
	tar -xzvf miniupnpc-1.6.tar.gz; \
	cd miniupnpc-1.6; \
	make; \
	make install; \
	cd /; \
	rm -rf /miniupnpc-1.6;rm miniupnpc-1.6.tar.gz
RUN mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown developer:developer -R /home/developer
#RUN echo 0 > /proc/sys/kernel/yama/ptrace_scope
ENV HOME /home/developer
RUN mkdir /pigeoncoin; chown -R developer:developer /pigeoncoin
WORKDIR /pigeoncoin
