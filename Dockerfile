version: '3.8'

services:
  akaunting:
    image: akaunting/akaunting:latest
    ports:
      - "80:80"
    volumes:
      - akaunting_data:/var/www/html
    environment:
      - APACHE_RUN_USER=www-data
      - APACHE_RUN_GROUP=www-data
      - APACHE_LOG_DIR=/var/log/apache2
    restart: unless-stopped

volumes:
  akaunting_data:
