FROM php:7.0-fpm

RUN apt-get update

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install redis-3.1.0 \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable \
        redis \
        xdebug


RUN pecl channel-update pecl.php.net


RUN docker-php-ext-install \
        bcmath \
        gettext

RUN apt-get install -y \
        libbz2-dev \
        zlib1g-dev \
    && docker-php-ext-install \
        zip \
        bz2

RUN apt-get install -y \
        libexif-dev \
    && docker-php-ext-install \
        exif


RUN apt-get install -y \
        libgearman-dev \
    && (cd /tmp \
        && curl -sL https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.3.tar.gz | tar xz \
        && cd pecl-gearman-gearman-2.0.3 \
        && phpize \
        && ./configure \
        && make && make install) \
    && rm -rf /tmp/pecl-gearman-gearman-2.0.3 \
    && docker-php-ext-enable gearman.so

RUN pecl install igbinary \
    && docker-php-ext-enable igbinary

RUN apt-get install -y \
        libmagickwand-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick.so

RUN apt-get install -y \
        libicu-dev \
    && docker-php-ext-install intl

RUN apt-get install -y \
        libmemcached-dev \
    && (cd /tmp \
        && curl -sL https://github.com/php-memcached-dev/php-memcached/archive/v3.0.2.tar.gz | tar xz \
        && cd php-memcached-3.0.2 \
        && phpize \
        && ./configure --disable-memcached-sasl --enable-memcached-igbinary \
        && make && make install) \
    && rm -rf /tmp/php-memcached-3.0.2 \
    && docker-php-ext-enable memcached.so

RUN apt-get install -y \
        autoconf \
        g++ \
        make \
        openssl \
        libssl-dev \
        libcurl4-openssl-dev \
        pkg-config \
        libsasl2-dev \
        libpcre3-dev \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb.so

RUN docker-php-ext-install mysqli

RUN docker-php-ext-install pcntl

RUN docker-php-ext-install pdo_mysql

RUN apt-get install -y libpq-dev \
    #docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo_pgsql pgsql

RUN docker-php-ext-install shmop

RUN docker-php-ext-install sockets

RUN docker-php-ext-install sysvmsg sysvsem sysvshm

RUN docker-php-ext-install wddx

RUN apt-get install libxslt-dev \
    && docker-php-ext-install xsl

RUN docker-php-ext-install opcache

RUN docker-php-ext-install calendar

