FROM httpd:2.4-alpine

RUN apk update && apk add openssl

RUN openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -keyout /usr/local/apache2/conf/server.key -out /usr/local/apache2/conf/server.crt

COPY privkey.pem /var/www/privkey.pem
COPY fullchain.pem /var/www/fullchain.pem
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY vhost.conf /usr/local/apache2/conf/extra/vhost.conf
