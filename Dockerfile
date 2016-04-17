FROM alpine:edge
MAINTAINER Adrian Hobbs <adrianhobbs@gmail.com>
ENV PACKAGE "py-pip"

# Install packages and use pip to update
RUN	apk add --no-cache $PACKAGE && \
	pip install --upgrade pip && \
	pip install --upgrade setuptools && \
	pip install pytest pytest-runner && \
	pip install flexget && \
	# Add a user to run as non root
	adduser -D -g '' flexget

USER flexget
ENV HOME /home/flexget

CMD ["/usr/bin/flexget","daemon","start"]

