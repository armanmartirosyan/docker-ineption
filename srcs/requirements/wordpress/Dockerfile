FROM debian:buster

ENV PHP_VERSION 7.3

RUN mkdir -p /run/php

RUN apt update -y && apt upgrade -y

RUN apt install -y \
    curl \
    wget \
    php${PHP_VERSION} \
    php${PHP_VERSION}-cgi \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-pdo \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-redis \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/

COPY ./tools/setup_wp-cli.sh /usr/bin
RUN chmod +x /usr/bin/setup_wp-cli.sh

ENTRYPOINT ["/usr/bin/setup_wp-cli.sh"]

EXPOSE 9000

CMD [ "/usr/sbin/php-fpm7.3", "-F" ]
