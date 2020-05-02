FROM registry.oskk.1solution.ru/docker-images/mono-docker:latest
ARG VERSION
ARG BUILD

ARG user_uid="1000"
ARG user_gid="1000"

RUN groupadd -r user --gid=$user_gid \
  && mkdir /home/user \
  && useradd -r -g user --uid=$user_uid --home-dir /home/user --shell=/bin/bash user 

RUN set -xe \
	&& curl -o  oscript.deb -fSL https://oscript.io/downloads/${BUILD}/x64/onescript-engine_${VERSION}_all.deb \
    && dpkg -i oscript.deb \
    && rm -f oscript.deb \
    && chown -R user:user /home/user /usr/share/oscript /usr/bin/

USER user