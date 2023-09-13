# Builder stage
FROM php:8.2-fpm AS builder

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libzip-dev \
    unzip \
    git

# Instalar y habilitar extensiones requeridas
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb \
    && docker-php-ext-install zip

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

# Copiar los archivos de configuración de Composer
COPY composer.json composer.lock* ./

# Instalar dependencias sin los paquetes de desarrollo (--no-dev)
RUN composer install --no-dev

# -----------------------------

# Stage final
FROM php:8.2-fpm-alpine

# Instalar las dependencias necesarias
RUN apk add --no-cache libpq \
    autoconf \
    g++ \
    make \
    unzip \
    git

# Instalar y habilitar la extensión MongoDB
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

WORKDIR /var/www/html

# Copiar los archivos de la etapa anterior
COPY --from=builder /var/www/html/vendor ./vendor
COPY . .

# Establecer los permisos adecuados para el usuario www-data
RUN chown -R www-data:www-data /var/www/html

CMD ["php-fpm"]
