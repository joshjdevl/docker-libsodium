from ubuntu:precise
MAINTAINER joshjdevl < joshjdevl [at] gmail {dot} com>

ENV DEBIAN_FRONTEND noninteractive

#ENV PATH /usr/local/opt/python/current/bin:/usr/local/opt/apache/current/bin:/usr/local/opt/redis/current/bin:$PATH
ENV NDK_ROOT /installs/android-ndk-r9c


RUN apt-get update
RUN apt-get install -y python-software-properties
RUN apt-get update
RUN apt-get install -y wget git
RUN mkdir /installs
RUN cd /installs && wget http://dl.google.com/android/ndk/android-ndk-r9c-linux-x86_64.tar.bz2
RUN apt-get install bzip2
RUN cd /installs && tar -xvf android-ndk-r9c-linux-x86_64.tar.bz2
RUN cd /installs && git clone https://github.com/jedisct1/libsodium.git
RUN apt-get -y install autoconf autoconf automake build-essential
RUN apt-get -y install autogen libtool
RUN apt-get -y install gettext-base gettext
RUN cd /installs/libsodium && ./autogen.sh

ENV PATH /installs/libsodium/android-toolchain/bin:/installs/android-ndk-r9c:$PATH
RUN apt-get install -y vim
RUN  /installs/android-ndk-r9c/build/tools/make-standalone-toolchain.sh --platform=android-14 --arch=arm --install-dir=/installs/libsodium/android-toolchain --system=linux-x86_64
RUN cd /installs/libsodium && ./dist-build/android.sh 
