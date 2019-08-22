FROM tozd/runit:ubuntu-xenial

EXPOSE 25/tcp 465/tcp 587/tcp

VOLUME /var/log/postfix
VOLUME /var/spool/postfix

ENV MAILNAME mail.example.com
ENV MY_NETWORKS 172.17.0.0/16 127.0.0.0/8
ENV MY_DESTINATION localhost.localdomain, localhost
ENV ROOT_ALIAS admin@example.com

# /etc/aliases should be available at postfix installation.
COPY ./etc/aliases /etc/aliases

RUN echo postfix postfix/main_mailer_type string "'Internet Site'" | debconf-set-selections && \
 echo postfix postfix/mynetworks string "127.0.0.0/8" | debconf-set-selections && \
 echo postfix postfix/mailname string temporary.example.com | debconf-set-selections && \
 apt-get update -q -q && \
 apt-get --yes --force-yes install postfix && \
 apt-get --yes --force-yes --no-install-recommends install rsyslog && \
 apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

# We disable IPv6 for now, IPv6 is available in Docker even if the host does not have IPv6 connectivity.
RUN \
 postconf -e mydestination="localhost.localdomain, localhost" && \
 postconf -e smtpd_banner='$myhostname ESMTP $mail_name' && \
 postconf -# myhostname && \
 postconf -e inet_protocols=ipv4 && \
 sed -i 's/\/var\/log\/mail/\/var\/log\/postfix\/mail/' /etc/rsyslog.d/50-default.conf

COPY ./etc /etc
