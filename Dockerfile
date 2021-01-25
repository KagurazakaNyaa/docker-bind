FROM debian:buster-backports

LABEL maintainer="i@kagurazakanyaa.com"

ENV BIND_USER=bind \
    DATA_DIR=/data

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg ca-certificates \
 && apt-key adv --fetch-keys https://download.webmin.com/jcameron-key.asc \
 && echo "deb https://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -t buster-backports -y \
      bind9 bind9-host dnsutils webmin \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 53/tcp 10000/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/sbin/named"]
