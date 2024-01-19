FROM debian:buster

RUN	apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl


RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs && rm -rf /var/lib/apt/lists/*

COPY ./site /var/www/html/
WORKDIR /var/www/html/

RUN npm init -y && npm install express

EXPOSE 3000

CMD ["node", "server.js"]