FROM alpine:3.9.2

LABEL author.name="Rusty Gerard"
LABEL author.email="rusty.gerard@gmail.com"
LABEL description="Build environment for NES/cc65 projects: cc65, nestools, wine64, famitracker"

ENV prefix=/usr/local
ENV DISPLAY=:99

RUN apk update && apk upgrade && apk add \
  build-base \
  git \
  libpng-dev \
  unzip \
  wine \
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

ENTRYPOINT sh
