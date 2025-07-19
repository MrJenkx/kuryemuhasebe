FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libpq-dev \
    libzip-dev \
    zip \
    && docker-php-ext-install pdo pdo_pgsql zip

RUN a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html
WORKDIR /var/www/html

RUN composer install --no-dev --optimize-autoloader
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN php artisan config:cache

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "public"]
