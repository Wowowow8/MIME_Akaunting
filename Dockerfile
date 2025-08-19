FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Copy your app files into the container
COPY . /var/www/html

# Install Composer and Laravel dependencies
RUN apt-get update && apt-get install -y unzip zip git curl \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && composer install --no-interaction --prefer-dist --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Copy Apache virtual host config
RUN echo "<VirtualHost *:80>
    DocumentRoot /var/www/html/public
    <Directory /var/www/html/public>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy your .env variables
ENV DB_CONNECTION=mysql \
    DB_HOST=mime-akaunting-db-mime-akaunting-db.d.aivencloud.com \
    DB_PORT=19654 \
    DB_DATABASE=defaultdb \
    DB_USERNAME=avnadmin \
    DB_PASSWORD=AVNS_PDQskxj_JtWnNBYY-bR \
    DB_SSLMODE=REQUIRED

# Laravel config and cache
RUN php artisan config:clear && php artisan config:cache

EXPOSE 80

CMD ["apache2-foreground"]
