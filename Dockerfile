#This dockerfile will create a opengrok image

FROM buildpack-deps:sid-curl

RUN apt-get update && apt-get install -y --no-install-recommends \
		bzip2 \
		unzip \
		zx-utils \
	&& rm -rf /var/lib/apt/lists/*

RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list

#use UTF-8
ENV LANG C.UTF-8

#learn from openjdk dockerfile
RUN { \
		echo '#!/binm/sh'; \
		echo 'set-e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javaac || which java)")")"; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-9-openjdk

RUN set -x \
	&& apt-get update \
	&& apt-get install -y \
		openjdk-9-jre \
	&& rm -rf /var/lib/apt/lists/* \
	&& [ "$JAVA_HOME" = "$docker-java-home)" ]

