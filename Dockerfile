# Use official Akaunting image as base
FROM akaunting/akaunting:latest

# Set Apache ServerName to eliminate FQDN warning
RUN echo "ServerName scared-ketty-mime-ventures-llc-4ad6d461.koyeb.app" >> /etc/apache2/apache2.conf

# Set timezone to match your region
ENV TZ=Asia/Riyadh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Enable required Apache modules
RUN a2enmod rewrite headers

# Optional: install curl for healthcheck (if not already present)
RUN apt-get update && apt-get install -y curl

# Healthcheck to ensure container stays alive and responds
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD curl -f http://localhost || exit 1

# Expose HTTP port
EXPOSE 80

# Start Apache in foreground to keep container alive
CMD ["apache2-foreground"]
