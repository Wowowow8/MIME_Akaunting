FROM akaunting/akaunting:latest

# Optional: if you want to run install scripts automatically
# ENV APP_KEY=base64:xxx
# ENV APP_INSTALLED=true
# COPY .env /var/www/html/.env

# Run artisan commands (optional)
# RUN php artisan migrate --force

EXPOSE 80
