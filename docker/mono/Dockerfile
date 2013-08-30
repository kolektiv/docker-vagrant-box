FROM ubuntu:12.10
MAINTAINER Andrew Cherry <andrew@xyncro.com>

# Update apt repositories
RUN apt-get update

# Install build tooling
RUN apt-get install -qy git autoconf automake libtool g++ gettext mono-gmcs

# Install dev versions of libraries
RUN apt-get install -qy libglib2.0-dev libpng12-dev libx11-dev 
RUN apt-get install -qy libfreetype6-dev libfontconfig1-dev 
RUN apt-get install -qy libtiff5-dev libjpeg8-dev libgif-dev libexif-dev

# Clone sources
RUN mkdir /src
RUN git clone git://github.com/mono/mono.git /src/mono
RUN git clone git://github.com/mono/libgdiplus.git /src/libgdiplus

# Build libgdiplus
WORKDIR /src/libgdiplus
RUN ./autogen.sh --prefix=/usr
RUN make install

CMD ["/bin/bash"]

