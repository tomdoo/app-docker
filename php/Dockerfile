FROM php:7.2-fpm

RUN apt-get update && apt-get install -y \
    curl \
    git \
    libicu-dev \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    vim \
    wget \
    zip \
    sqlite3 libpq-dev libxml2-dev imagemagick \
    telnet \
    libmemcached-dev \
    acl

# PHP extensions
RUN docker-php-ext-install curl intl pdo_mysql mysqli zip \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd exif \
    && docker-php-ext-install soap

# intl + opcache
RUN docker-php-ext-enable opcache \
    && docker-php-ext-install intl \
    && docker-php-ext-enable soap

RUN apt-get install -y \
    cmake \
    libzmq3-dev

# Xdebug
RUN pecl install xdebug

# pncl
RUN docker-php-ext-install pcntl \
    && docker-php-ext-enable pcntl

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pecl install apcu \
    && docker-php-ext-enable apcu

RUN composer global require friendsofphp/php-cs-fixer \
    "squizlabs/php_codesniffer=*" \
    phpmd/phpmd \
    sebastian/phpcpd

WORKDIR "/var/www"

RUN docker-php-ext-install bcmath

# add custom config
COPY php.ini /usr/local/etc/php/

COPY permissions.sh /var/www
RUN chmod +x /var/www/permissions.sh

ENV COMPOSER_MEMORY_LIMIT=-1

RUN echo 'alias symfony="php bin/console"' >>~/.bashrc
RUN echo 'alias sydebug="php -dxdebug.remote_enable=1 -dxdebug.remote_autostart=On -dxdebug.idekey=PHPSTORM -dxdebug.remote_host=10.0.75.1 bin/console"' >>~/.bashrc
RUN echo 'alias ccdebug="php -dxdebug.remote_enable=1 -dxdebug.remote_autostart=On -dxdebug.idekey=PHPSTORM -dxdebug.remote_host=10.0.75.1 vendor/bin/codecept"' >>~/.bashrc
RUN echo 'alias codecept="php  vendor/bin/codecept"'>>~/.bashrc

RUN docker-php-ext-enable xdebug
RUN docker-php-ext-install xml

RUN apt-get install -y libgmp-dev re2c libmhash-dev libmcrypt-dev file
RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/
RUN docker-php-ext-configure gmp
RUN docker-php-ext-install gmp
