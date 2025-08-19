# Use official Akaunting image
FROM akaunting/akaunting:latest

# Set working directory
WORKDIR /var/www/html

# Environment configuration
ENV APP_NAME=Akaunting \
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
    DB_OPTIONS='--client_encoding=UTF8' \
    APACHE_DOCUMENT_ROOT=/var/www/html/public

# Enable Apache rewrite module and update config to serve from /public
RUN a2enmod rewrite && \
    sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf && \
    sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Laravel config optimization
RUN php artisan config:clear && php artisan config:cache

# Healthcheck to keep container alive
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost || exit 1

# Expose Apache port
EXPOSE 80

# Start Apache in foreground
ENTRYPOINT ["apache2-foreground"]
