#
# Haproxy Dockerfile
#
# https://github.com/dockerfile/haproxy
#

# Pull base image.
FROM ubuntu:14.04.2

# Install Haproxy.
RUN \
  echo deb http://archive.ubuntu.com/ubuntu trusty-backports main universe | \
      tee /etc/apt/sources.list.d/backports.list && \
  apt-get update && \
  apt-get install -y haproxy -t trusty-backports && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD haproxy.cfg /etc/haproxy/haproxy.cfg
ADD start.bash /haproxy-start

# Define mountable directories.
VOLUME ["/haproxy-override"]

# Define working directory.
WORKDIR /etc/haproxy

# Define default command.
CMD ["bash", "/haproxy-start"]

# Expose ports.
EXPOSE 80
EXPOSE 443
