FROM akaunting/akaunting:latest

# Optionally set working directory
WORKDIR /var/www/html

# You can copy your custom .env file if needed
# COPY .env /var/www/html/.env

# Expose default port
EXPOSE 80
