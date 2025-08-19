FROM akaunting/akaunting:latest

# Set working directory
WORKDIR /var/www/html

# Environment Variables
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
    APP_NAME=Akaunting \
    APP_ENV=production \
    APP_DEBUG=false \
    APP_KEY=base64:LOgi/XY/9KtOKt9HcpSlM+MBHYjXlRYWdeSpUOOqffw= \
    APP_URL=https://scared-ketty-mime-ventures-llc-4ad6d461.koyeb.app \
    APP_INSTALLED=true \
    CACHE_DRIVER=file \
    QUEUE_CONNECTION=sync \
    SESSION_DRIVER=cookie \
    DB_CONNECTION=pgsql \
    DB_HOST=ep-muddy-unit-abqx4aqs-pooler.eu-west-2.aws.neon.tech \
    DB_PORT=5432 \
    DB_DATABASE=neondb \
    DB_USERNAME=neondb_owner \
    DB_PASSWORD=npg_hQpPOi9KM0vC \
    DB_SSLMODE=require \
    DB_OPTIONS='--client_encoding=UTF8'

# Rebuild config cache (optional but safer for production)
RUN php artisan config:clear && php artisan config:cache

# Start Apache in foreground
CMD ["apache2-foreground"]

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf && \
    sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
