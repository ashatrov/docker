M php:7.0-fpm

RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends apt-utils \
    && pecl channel-update pecl.php.net \
    \
    \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    \
    \
    && apt-get install -y \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt \
    \
    \
    && docker-php-ext-install -j$(nproc) bcmath \
    \
    \
    && pecl install igbinary \
    && docker-php-ext-enable igbinary \
    \
    \
    && apt-get install -y \
        libbz2-dev \
        zlib1g-dev \
    && docker-php-ext-install -j$(nproc) \
        zip \
        bz2 \
    \
    \
    && apt-get install -y \
        libexif-dev \
    && docker-php-ext-install -j$(nproc) exif \
    \
    \
    && docker-php-ext-install -j$(nproc) gettext \
    \
    \
    && apt-get install -y \
        libgearman-dev \
    && (cd /tmp \
        && curl -sL https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.3.tar.gz | tar xz \
        && cd pecl-gearman-gearman-2.0.3 \
        && phpize \
        && ./configure \
        && make && make install) \
    && rm -rf /tmp/pecl-gearman-gearman-2.0.3 \
    && docker-php-ext-enable gearman.so \
    \
    \
    && apt-get install -y \
        libmagickwand-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick.so \
    \
    \
    && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install -j$(nproc) intl \
    \
    \
    && apt-get install -y \
        libmemcached-dev \
        zlib1g-dev \
    && (cd /tmp \
        && curl -sL https://github.com/php-memcached-dev/php-memcached/archive/v3.0.2.tar.gz | tar xz \
        && cd php-memcached-3.0.2 \
        && phpize \
        && ./configure --disable-memcached-sasl --enable-memcached-igbinary \
        && make && make install) \
    && rm -rf /tmp/php-memcached-3.0.2 \
    && docker-php-ext-enable memcached.so \
    \
    \
    && apt-get install -y \
        libmemcached-dev \
    && (cd /tmp \
        && curl -sL https://github.com/phpredis/phpredis/archive/3.1.2.tar.gz | tar xz \
        && cd phpredis-3.1.2 \
        && phpize \
        && ./configure --enable-redis-igbinary \
        && make && make install) \
    && rm -rf /tmp/phpredis-3.1.2 \
    && docker-php-ext-enable redis.so \
    \
    \
    && apt-get install -y \
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
    && docker-php-ext-enable mongodb.so \
    \
    \
    && apt-get install -y \
        libpq-dev \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && docker-php-ext-install -j$(nproc) pgsql \
    \
    \
    && apt-get install -y \
        libxslt-dev \
    && docker-php-ext-install -j$(nproc) xsl \
    \
    \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    \
    \
    && docker-php-ext-install -j$(nproc) mysqli \
    \
    \
    && docker-php-ext-install -j$(nproc) pcntl \
    \
    \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    \
    \
    && docker-php-ext-install -j$(nproc) shmop \
    \
    \
    && docker-php-ext-install -j$(nproc) sockets \
    \
    \
    && docker-php-ext-install -j$(nproc) sysvmsg \
    && docker-php-ext-install -j$(nproc) sysvsem \
    && docker-php-ext-install -j$(nproc) sysvshm \
    \
    \
    && docker-php-ext-install -j$(nproc) wddx \
    \
    \
    && docker-php-ext-install -j$(nproc) opcache \
    \
    \
    && docker-php-ext-install -j$(nproc) calendar \
    \
    \
    \
    \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

