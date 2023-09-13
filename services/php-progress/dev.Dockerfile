# Use the official PHP image with FPM
FROM php:8.2-fpm

# Install necessary system packages and PHP extensions
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libzip-dev \
    unzip \
    git \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \
    && docker-php-ext-install zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version  # Check Composer version
# Set the working directory
WORKDIR /var/www/html

# Copy the PHP application code
COPY . .

# Expose port 9000 for FPM
EXPOSE 9000

# Start PHP-FPM and execute Composer install
CMD ["php-fpm", "-F"]
