FROM ubuntu:trusty

ENV TERM linux

# Install Creator & xc32-gcc dependencies
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install g++ gcc binutils bzip2 flex python perl make \
libncurses5-dev libncursesw5-dev libssl-dev grep unzip zip gawk subversion \
zlib1g-dev build-essential git mercurial cmake python-nose python-lxml \
wget curl libc6:i386 device-tree-compiler

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo && \
chmod a+x /usr/bin/repo


RUN wget -O xc32.run http://ww1.microchip.com/downloads/en/DeviceDoc/xc32-v1.34-full-install-linux-installer.run && \
chmod a+x xc32.run && \
./xc32.run --mode unattended --unattendedmodeui none \
--netservername localhost && \
rm xc32.run
# Needed to let the xc32-gcc command work
ENV PATH $PATH:/opt/microchip/xc32/v1.34/bin/

RUN useradd -m -p build build

# switch to build user
USER build
WORKDIR /home/build/

CMD ["/bin/bash"]
