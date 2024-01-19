FROM debian:buster

RUN	apt update -y && apt upgrade -y
RUN apt install -y vsftpd && rm -rf /var/lib/apt/lists/*

COPY ./conf/vsftpd.conf /etc/
COPY ./tools/script.sh /usr/bin/
RUN chmod +x /usr/bin/script.sh

EXPOSE 21

CMD ["/usr/bin/script.sh"]