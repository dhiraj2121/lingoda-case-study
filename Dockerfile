FROM php:8.2-fpm-buster

COPY php.ini /usr/local/etc/php/conf.d/docker-php-config.ini

# Install utilities
RUN apt-get update && apt-get install -y \
    gnupg \
    g++ \
    procps \
    openssl \
    git \
    unzip \
    zlib1g-dev \
    libzip-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libicu-dev  \
    libonig-dev \
    libxslt1-dev \
    acl \
    netcat \
    && echo 'alias sf="php bin/console"' >> ~/.bashrc

RUN docker-php-ext-configure gd --with-jpeg --with-freetype 

RUN docker-php-ext-install \
    pdo pdo_mysql zip xsl gd intl opcache exif mbstring

# Set timezone
RUN ln -snf /usr/share/zoneinfo/Europe/Berlin /etc/localtime && echo Europe/Berlin > /etc/timezone \
    && printf '[PHP]\ndate.timezone = "%s"\n', Europe/Berlin > /usr/local/etc/php/conf.d/tzone.ini \
    && "date"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV COMPOSER_ALLOW_SUPERUSER=1

WORKDIR /var/www/symfony

COPY . /var/www/symfony

EXPOSE 9000