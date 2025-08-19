# Use Akaunting's official image as base
FROM akaunting/akaunting:latest

# Set Apache ServerName to suppress FQDN warnings
RUN echo "ServerName scared-ketty-mime-ventures-llc-4ad6d461.koyeb.app" >> /etc/apache2/apache2.conf

# Set timezone to Riyadh
ENV TZ=Asia/Riyadh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Enable Apache modules required by Akaunting
RUN a2enmod rewrite headers

# Optional: Add healthcheck for container monitoring
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD curl -f http://localhost || exit 1

# Expose HTTP port
EXPOSE 80

# Start Apache in foreground to keep container alive
CMD ["apache2-foreground"]
