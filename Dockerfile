FROM ubuntu:cosmic-20190311

LABEL author.name="Rusty Gerard"
LABEL author.email="rusty.gerard@gmail.com"
LABEL description="Build environment for NES/cc65 projects: cc65, nestools, wine32, famitracker"

ENV prefix=/usr/local
ENV DISPLAY=:99

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
  build-essential \
  git \
  libpng-dev \
  unzip \
  wget \
  wine32 \
  xvfb

WORKDIR /home/root/
ADD cc65/ cc65/
ADD nestools/ nestools/

WORKDIR /home/root/cc65/
RUN make && make install

WORKDIR /home/root/nestools/tools/
RUN make all
RUN for f in `find -type f` ; do [ -x $f ] && cp "$f" "/usr/local/bin/`basename $f`" ; done

WORKDIR /tmp/
RUN wget http://www.famitracker.com/files/FamiTracker-v0.4.6.zip
RUN unzip FamiTracker-v0.4.6.zip -d FamiTracker-v0.4.6
RUN mv FamiTracker-v0.4.6/FamiTracker.exe /usr/local/bin/famitracker.exe
RUN rm -rf FamiTracker-v0.4.6/

WORKDIR /home/root/
RUN rm -rf cc65/
RUN rm -rf nestools/

WORKDIR /home/root/work/

ENTRYPOINT bash
