# PHP 8.2 FPM'i temel al
FROM php:8.2-fpm

# Gerekli kütüphaneleri ve PHP eklentilerini kur
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql mbstring zip bcmath gd exif

# Composer'ı kur
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Çalışma dizinini ayarla
WORKDIR /var/www

# Dosya sahipliğini www-data kullanıcısına ver
RUN chown -R www-data:www-data /var/www

# www-data kullanıcısına geç
USER www-data

# Önce sadece composer dosyalarını kopyala (cache için)
COPY --chown=www-data:www-data composer.json composer.lock ./

# Proje bağımlılıklarını kur (vendor klasörünü oluşturacak)
RUN composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev --no-scripts

# Bütün proje dosyalarını kopyala
COPY --chown=www-data:www-data . .

# PHP-FPM'i çalıştır
CMD ["php-fpm"]