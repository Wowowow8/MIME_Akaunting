# Base image from Akaunting
FROM akaunting/akaunting:latest

# Set ServerName to eliminate Apache FQDN warning
RUN echo "ServerName scared-ketty-mime-ventures-llc-4ad6d461.koyeb.app" >> /etc/apache2/apache2.conf

# Optional: Set timezone (adjust as needed)
ENV TZ=Asia/Riyadh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Optional: Enable Apache modules if needed
RUN a2enmod rewrite

# Optional: Add healthcheck for container monitoring
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD curl -f http://localhost || exit 1

# Expose HTTP port
EXPOSE 80

# Start Apache in foreground
CMD ["apache2-foreground"]
