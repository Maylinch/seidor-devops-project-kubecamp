FROM php:8.2-fpm AS builder

RUN apt-get update && apt-get install -y \
    libssl-dev \
    libzip-dev \
    unzip \
    git \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \
    && docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY composer.json composer.lock* ./

RUN composer install --no-dev

# -----------------------------

FROM php:8.2-fpm-alpine

RUN apk add --no-cache libpq

WORKDIR /var/www/html

COPY --from=builder /var/www/html/vendor ./vendor

COPY . .

CMD ["php-fpm"]