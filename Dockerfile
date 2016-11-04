# Creator openwrt build dockerfile
# ================================
FROM ubuntu:xenial
MAINTAINER IMGTEC

# Add multiarch support
RUN dpkg --add-architecture i386

# Openwrt dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
binutils flex perl gawk grep file openssl bzip2 unzip zip rsync bc \
build-essential bsdmainutils cmake device-tree-compiler \
libncurses5-dev libncursesw5-dev libssl-dev zlib1g-dev libc6:i386 \
ca-certificates wget curl subversion git mercurial \
python python-nose python-lxml && \
wget -O /usr/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && \
chmod a+x /usr/bin/repo

# Constrained device dependencies
RUN wget -O xc32.run http://ww1.microchip.com/downloads/en/DeviceDoc/xc32-v1.34-full-install-linux-installer.run && \
chmod a+x xc32.run && \
./xc32.run --mode unattended --unattendedmodeui none --netservername localhost && \
rm xc32.run

# MIPS official toolchain
RUN mkdir -p /opt/toolchains && wget -qO- http://codescape-mips-sdk.imgtec.com/components/toolchain/2016.05-03/Codescape.GNU.Tools.Package.2016.05-03.for.MIPS.IMG.Linux.CentOS-5.x86.tar.gz | tar -xz -C /opt/toolchains/

# Useful tools
RUN wget -O /usr/bin/checkpatch.pl https://raw.githubusercontent.com/torvalds/linux/master/scripts/checkpatch.pl && \
chmod +x /usr/bin/checkpatch.pl

# Set all env in one go to avoid too many layers
ENV PATH $PATH:/opt/microchip/xc32/v1.34/bin/

# Add and use build user
RUN useradd -m -p build build
USER build
WORKDIR /home/build/

CMD ["/bin/bash"]
