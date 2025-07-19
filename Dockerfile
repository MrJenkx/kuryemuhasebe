# Laravel için PHP 8.2 tabanlı resmi görüntü
FROM php:8.2-fpm

# Sistem paketleri ve Laravel ihtiyaçları
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libpq-dev \
    zip \
    npm \
    nodejs \
    && docker-php-ext-install pdo pdo_pgsql mbstring zip bcmath

# Composer yükle
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Çalışma dizinini ayarla
WORKDIR /var/www

# Laravel dosyalarını kopyala
COPY . .

# Laravel bağımlılıklarını yükle
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Laravel için APP_KEY oluştur
RUN php artisan key:generate

# Storage ve cache klasör izinleri
RUN chmod -R 775 storage bootstrap/cache

# Laravel uygulamasını başlat
CMD php artisan serve --host=0.0.0.0 --port=8000
