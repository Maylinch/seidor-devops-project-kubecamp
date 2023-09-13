FROM php:8.2-bullseye AS builder

RUN apt update && apt install -y git

LABEL lang="php"

COPY --from=composer:2.5.8 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY composer.json composer.lock* ./

RUN composer install --no-dev


# -----------------------------------------------------

FROM php:8.2-alpine

WORKDIR /var/www/html

RUN apk add --no-cache libpq

COPY --from=builder /var/www/html/vendor ./vendor