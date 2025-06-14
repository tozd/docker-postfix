FROM registry.gitlab.com/tozd/docker/dinit:alpine-320

EXPOSE 25/tcp 465/tcp 587/tcp

VOLUME /var/log/postfix
VOLUME /var/spool/postfix

ENV MAILNAME=mail.example.com
ENV MY_NETWORKS="172.17.0.0/16 127.0.0.0/8"
ENV MY_DESTINATION="localhost.localdomain, localhost"
ENV ROOT_ALIAS="admin@example.com"
ENV LOG_TO_STDOUT=0

# /etc/aliases should be available at postfix installation.
COPY ./etc/aliases /etc/aliases

RUN apk add --no-cache postfix postfix-pcre

# We disable IPv6 for now, IPv6 is available in Docker even if the host does not have IPv6 connectivity.
RUN postconf -e mydestination="localhost.localdomain, localhost" && \
  postconf -e smtpd_banner='$myhostname ESMTP $mail_name' && \
  postconf -# myhostname && \
  postconf -e inet_protocols=ipv4

ENV POSTFIX_PATH="/usr/libexec/postfix/master"

COPY ./etc/aliases /etc/aliases
COPY ./etc/service/postfix /etc/service/postfix
