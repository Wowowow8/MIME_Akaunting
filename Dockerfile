FROM akaunting/akaunting:latest

# Set working directory
WORKDIR /var/www/html

# Set environment variables for MySQL
ENV DB_CONNECTION=mysql \
    DB_HOST=mime-akaunting-db-mime-akaunting-db.d.aivencloud.com \
    DB_PORT=19654 \
    DB_DATABASE=defaultdb \
    DB_USERNAME=avnadmin \
    DB_PASSWORD=AVNS_PDQskxj_JtWnNBYY-bR \
    DB_SSLMODE=require \
    APP_ENV=production \
    APP_DEBUG=false \
    APP_KEY=base64:XwbL0pOfakjTXf2DVa8l0MuP0xKldz+ceXTLbm0dKIg= \
    APP_URL=https://scared-ketty-mime-ventures-llc-4ad6d461.koyeb.app

# Clear and cache configuration
RUN php artisan config:clear && php artisan config:cache
